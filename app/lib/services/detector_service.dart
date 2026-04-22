import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../models/detection_result.dart';

const int _inputSize        = 640;
const double _confThreshold = 0.15;   // Lowered for better real-world sensitivity
const double _iouThreshold  = 0.45;

// ─── Top-level isolate function: preprocessing + inference ───────────────────
// Runs inside compute() to keep the UI thread free.
// Returns {'output': Float32List, 'dx': int, 'dy': int} — output flattened in NCHW order.
// dx/dy are the letterbox padding offsets needed to un-map box coordinates.
Map<String, dynamic> _preprocessAndInfer(Map<String, dynamic> args) {
  final isJpeg        = args['isJpeg']        as bool;
  final isBGRA        = args['isBGRA']        as bool;
  final yBytes        = args['yBytes']        as Uint8List;
  final yStride       = args['yStride']       as int;
  final uBytes        = args['uBytes']        as Uint8List;
  final vBytes        = args['vBytes']        as Uint8List;
  final uvStride      = args['uvStride']      as int;
  final uvPixelStride = args['uvPixelStride'] as int;
  final width         = args['width']         as int;
  final height        = args['height']        as int;
  final address       = args['address']       as int;
  final numChannels   = args['numChannels']   as int;
  final numBoxes      = args['numBoxes']      as int;

  // 1. Decode / convert camera frame → RGB img.Image
  img.Image? decoded;
  if (isJpeg) {
    decoded = img.decodeJpg(yBytes);
  } else if (isBGRA) {
    // iOS BGRA8888: single plane, 4 bytes per pixel in B-G-R-A order
    decoded = img.Image(width: width, height: height);
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        final idx = row * yStride + col * 4;
        final b = yBytes[idx];
        final g = yBytes[idx + 1];
        final r = yBytes[idx + 2];
        decoded.setPixelRgb(col, row, r, g, b);
      }
    }
  } else {
    // YUV420 (Android): planes[0]=Y, planes[1]=U/Cb, planes[2]=V/Cr
    final out = img.Image(width: width, height: height);
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        final yVal  = yBytes[row * yStride + col];
        final uvIdx = (row ~/ 2) * uvStride + (col ~/ 2) * uvPixelStride;
        final uVal  = uBytes[uvIdx];                // Cb — planes[1]
        final vVal  = vBytes[uvIdx];                // Cr — planes[2]
        final r = (yVal + 1.370705  * (vVal - 128)).round().clamp(0, 255);
        final g = (yVal - 0.337633  * (uVal - 128) - 0.698001 * (vVal - 128)).round().clamp(0, 255);
        final b = (yVal + 1.732446  * (uVal - 128)).round().clamp(0, 255);
        out.setPixelRgb(col, row, r, g, b);
      }
    }
    decoded = out;
  }
  if (decoded == null) return {'output': Float32List(0), 'dx': 0, 'dy': 0};

  // 2. Letterbox-resize to 640×640, preserving aspect ratio (YOLO gray=114 padding)
  final scale  = _inputSize / (decoded.width > decoded.height ? decoded.width : decoded.height);
  final newW   = (decoded.width  * scale).round();
  final newH   = (decoded.height * scale).round();
  final dx     = (_inputSize - newW) ~/ 2;
  final dy     = (_inputSize - newH) ~/ 2;
  final scaled = img.copyResize(decoded, width: newW, height: newH);
  final padded = img.Image(width: _inputSize, height: _inputSize);
  img.fill(padded, color: img.ColorRgb8(114, 114, 114));
  img.compositeImage(padded, scaled, dstX: dx, dstY: dy);

  // DEBUG: log a centre pixel to prove preprocessing is non-trivial
  final dbgPx = padded.getPixel(_inputSize ~/ 2, _inputSize ~/ 2);
  print('[Detector-dbg] centre px R=${dbgPx.r.toInt()} G=${dbgPx.g.toInt()} B=${dbgPx.b.toInt()}  decoded ${decoded.width}x${decoded.height}  padded dx=$dx dy=$dy');

  // 3. Build NHWC input tensor [1, 640, 640, 3]
  final input = [
    List.generate(_inputSize, (row) =>
      List.generate(_inputSize, (col) {
        final pixel = padded.getPixel(col, row);
        return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
      }),
    ),
  ];

  // 4. Run inference
  final interpreter   = Interpreter.fromAddress(address);
  final outputNested  = List.generate(1, (_) =>
    List.generate(numChannels, (_) => List.filled(numBoxes, 0.0)));
  interpreter.run(input, outputNested);

  // 5. Flatten [1][numChannels][numBoxes] → Float32List
  final outputFlat = Float32List(numChannels * numBoxes);
  final inner      = outputNested[0];
  for (int c = 0; c < numChannels; c++) {
    final row = inner[c];
    for (int b = 0; b < numBoxes; b++) {
      outputFlat[c * numBoxes + b] = row[b];
    }
  }
  return {'output': outputFlat, 'dx': dx, 'dy': dy};
}

// ─── DetectorService ─────────────────────────────────────────────────────────
class DetectorService {
  Interpreter? _interpreter;
  List<String>? _labels;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> load() async {
    final options = InterpreterOptions()..threads = 4;
    _interpreter = await Interpreter.fromAsset(
      'assets/models/product_detection.tflite',
      options: options,
    );
    final labelData = await rootBundle.loadString('assets/models/labels.txt');
    _labels  = labelData.trim().split('\n');
    _isLoaded = true;

    final inShape  = _interpreter!.getInputTensor(0).shape;
    final outShape = _interpreter!.getOutputTensor(0).shape;
    debugPrint('[Detector] Input  shape : $inShape');
    debugPrint('[Detector] Output shape : $outShape');
    debugPrint('[Detector] Labels count : ${_labels?.length}');
  }

  Future<void> dispose() async {
    _interpreter?.close();
    _isLoaded = false;
  }

  Future<DetectionResult> detect(CameraImage cameraImage) async {
    if (!_isLoaded || _interpreter == null) {
      return const DetectionResult(boxes: [], inferenceTimeMs: 0);
    }

    final sw          = Stopwatch()..start();
    final isJpeg      = cameraImage.format.group == ImageFormatGroup.jpeg;
    final isBGRA      = cameraImage.format.group == ImageFormatGroup.bgra8888;
    final needsUV     = !isJpeg && !isBGRA;
    final outShape    = _interpreter!.getOutputTensor(0).shape;
    final numClasses  = _labels?.length ?? 43;
    final numChannels = numClasses + 4;
    final bool isNCHW  = outShape.length >= 3 && outShape[1] == numChannels;
    final int numBoxes = isNCHW ? outShape[2] : outShape[1];

    final result = await compute(_preprocessAndInfer, {
      'isJpeg'       : isJpeg,
      'isBGRA'       : isBGRA,
      'yBytes'       : Uint8List.fromList(cameraImage.planes[0].bytes),
      'yStride'      : cameraImage.planes[0].bytesPerRow,
      'uBytes'       : needsUV ? Uint8List.fromList(cameraImage.planes[1].bytes) : Uint8List(0),
      'vBytes'       : needsUV ? Uint8List.fromList(cameraImage.planes[2].bytes) : Uint8List(0),
      'uvStride'     : needsUV ? cameraImage.planes[1].bytesPerRow : 0,
      'uvPixelStride': needsUV ? (cameraImage.planes[1].bytesPerPixel ?? 1) : 1,
      'width'        : cameraImage.width,
      'height'       : cameraImage.height,
      'address'      : _interpreter!.address,
      'numChannels'  : numChannels,
      'numBoxes'     : numBoxes,
    });

    sw.stop();

    final outputFlat = result['output'] as Float32List;
    if (outputFlat.isEmpty) {
      return const DetectionResult(boxes: [], inferenceTimeMs: 0);
    }

    final dx = result['dx'] as int;
    final dy = result['dy'] as int;

    final boxes    = isNCHW
        ? _parseNCHW(outputFlat, numBoxes, numClasses, dx, dy)
        : _parseNHWC(outputFlat, numBoxes, numClasses, dx, dy);
    final nmsBoxes = _nms(boxes);

    debugPrint('[Detector] ${sw.elapsedMilliseconds}ms  raw=${boxes.length}  nms=${nmsBoxes.length}  isNCHW=$isNCHW');

    return DetectionResult(boxes: nmsBoxes, inferenceTimeMs: sw.elapsedMilliseconds);
  }

  // NCHW: outputFlat[channel * numBoxes + box]
  // dx/dy = letterbox padding offsets; used to un-map coords back to original image space.
  List<DetectionBox> _parseNCHW(
      Float32List flat, int numBoxes, int numClasses, int dx, int dy) {
    final boxes   = <DetectionBox>[];
    final regionW = _inputSize - 2 * dx;   // image width inside letterbox
    final regionH = _inputSize - 2 * dy;   // image height inside letterbox
    double topScore = 0;
    for (int i = 0; i < numBoxes; i++) {
      final cx = flat[0 * numBoxes + i];
      final cy = flat[1 * numBoxes + i];
      final w  = flat[2 * numBoxes + i];
      final h  = flat[3 * numBoxes + i];
      double bestScore = 0;
      int bestClass    = 0;
      for (int c = 0; c < numClasses; c++) {
        final s = flat[(4 + c) * numBoxes + i];
        if (s > bestScore) { bestScore = s; bestClass = c; }
      }
      if (bestScore > topScore) topScore = bestScore;
      if (bestScore >= _confThreshold) {
        // Un-letterbox: convert from letterboxed 640×640 space → original image [0,1]
        boxes.add(DetectionBox(
          x: (cx - dx) / regionW, y: (cy - dy) / regionH,
          width: w / regionW,     height: h / regionH,
          classId: _labels?[bestClass] ?? 'unknown',
          confidence: bestScore,
        ));
      }
    }
    debugPrint('[Detector] maxRawScore=${topScore.toStringAsFixed(4)}  dx=$dx  dy=$dy');
    return boxes;
  }

  // NHWC: outputFlat[box * numChannels + channel]
  List<DetectionBox> _parseNHWC(
      Float32List flat, int numBoxes, int numClasses, int dx, int dy) {
    final numCh    = numClasses + 4;
    final boxes    = <DetectionBox>[];
    final regionW  = _inputSize - 2 * dx;
    final regionH  = _inputSize - 2 * dy;
    double topScore = 0;
    for (int i = 0; i < numBoxes; i++) {
      final base = i * numCh;
      final cx = flat[base];
      final cy = flat[base + 1];
      final w  = flat[base + 2];
      final h  = flat[base + 3];
      double bestScore = 0;
      int bestClass    = 0;
      for (int c = 0; c < numClasses; c++) {
        final s = flat[base + 4 + c];
        if (s > bestScore) { bestScore = s; bestClass = c; }
      }
      if (bestScore > topScore) topScore = bestScore;
      if (bestScore >= _confThreshold) {
        boxes.add(DetectionBox(
          x: (cx - dx) / regionW, y: (cy - dy) / regionH,
          width: w / regionW,     height: h / regionH,
          classId: _labels?[bestClass] ?? 'unknown',
          confidence: bestScore,
        ));
      }
    }
    debugPrint('[Detector] maxRawScore=${topScore.toStringAsFixed(4)}  dx=$dx  dy=$dy');
    return boxes;
  }

  List<DetectionBox> _nms(List<DetectionBox> boxes) {
    if (boxes.isEmpty) return [];
    boxes.sort((a, b) => b.confidence.compareTo(a.confidence));
    final kept = <DetectionBox>[];
    for (final box in boxes) {
      bool suppressed = false;
      for (final k in kept) {
        if (_iou(box, k) > _iouThreshold) { suppressed = true; break; }
      }
      if (!suppressed) kept.add(box);
    }
    return kept;
  }

  double _iou(DetectionBox a, DetectionBox b) {
    final ax1 = a.x - a.width  / 2, ay1 = a.y - a.height / 2;
    final ax2 = a.x + a.width  / 2, ay2 = a.y + a.height / 2;
    final bx1 = b.x - b.width  / 2, by1 = b.y - b.height / 2;
    final bx2 = b.x + b.width  / 2, by2 = b.y + b.height / 2;
    final iw = (ax2 < bx2 ? ax2 : bx2) - (ax1 > bx1 ? ax1 : bx1);
    final ih = (ay2 < by2 ? ay2 : by2) - (ay1 > by1 ? ay1 : by1);
    if (iw <= 0 || ih <= 0) return 0.0;
    final inter = iw * ih;
    return inter / (a.width * a.height + b.width * b.height - inter);
  }
}
