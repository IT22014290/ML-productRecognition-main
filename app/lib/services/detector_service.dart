import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import '../models/detection_result.dart';

const double _confThreshold = 0.15;  // Lowered to allow kohomba_soup through
const double _iouThreshold  = 0.45;

// ─── Persistent inference isolate entry ──────────────────────────────────────
// Spawned ONCE in load(); processes every frame on the same OS thread.
// Thread-stable execution lets NNAPI/GPU delegates work reliably —
// delegates created in a given thread must also run inference on that thread.
void _inferenceIsolateEntry(SendPort mainSendPort) async {
  final port = ReceivePort();
  mainSendPort.send(port.sendPort);
  await for (final dynamic msg in port) {
    if (msg == null) break; // null = shutdown signal
    final map     = msg as Map<String, dynamic>;
    final replyTo = map['replyPort'] as SendPort;
    try {
      replyTo.send(_preprocessAndInfer(map));
    } catch (_) {
      replyTo.send({'output': Float32List(0), 'dx': 0, 'dy': 0});
    }
  }
}

// ─── Top-level isolate function: preprocessing + inference ───────────────────
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
  final inputSize     = args['inputSize']     as int;

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
        decoded.setPixelRgb(col, row, yBytes[idx + 2], yBytes[idx + 1], yBytes[idx]);
      }
    }
  } else {
    // YUV420 (Android): planes[0]=Y, planes[1]=U/Cb, planes[2]=V/Cr
    final out = img.Image(width: width, height: height);
    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        final yVal  = yBytes[row * yStride + col];
        final uvIdx = (row ~/ 2) * uvStride + (col ~/ 2) * uvPixelStride;
        final uVal  = uBytes[uvIdx];
        final vVal  = vBytes[uvIdx];
        final r = (yVal + 1.370705  * (vVal - 128)).round().clamp(0, 255);
        final g = (yVal - 0.337633  * (uVal - 128) - 0.698001 * (vVal - 128)).round().clamp(0, 255);
        final b = (yVal + 1.732446  * (uVal - 128)).round().clamp(0, 255);
        out.setPixelRgb(col, row, r, g, b);
      }
    }
    decoded = out;
  }
  if (decoded == null) return {'output': Float32List(0), 'dx': 0, 'dy': 0};

  // 2. Letterbox-resize to inputSize×inputSize, preserving aspect ratio (YOLO gray=114 padding)
  final scale  = inputSize / (decoded.width > decoded.height ? decoded.width : decoded.height);
  final newW   = (decoded.width  * scale).round();
  final newH   = (decoded.height * scale).round();
  final dx     = (inputSize - newW) ~/ 2;
  final dy     = (inputSize - newH) ~/ 2;
  final scaled = img.copyResize(decoded, width: newW, height: newH);
  final padded = img.Image(width: inputSize, height: inputSize);
  img.fill(padded, color: img.ColorRgb8(114, 114, 114));
  img.compositeImage(padded, scaled, dstX: dx, dstY: dy);

  // 3. Build flat NHWC Float32List; getBytes() avoids per-pixel Dart object allocations.
  final rgbBytes = padded.getBytes(order: img.ChannelOrder.rgb);
  final inputBuf = Float32List(rgbBytes.length);
  const invScale = 1.0 / 255.0;
  for (int i = 0; i < rgbBytes.length; i++) {
    inputBuf[i] = rgbBytes[i] * invScale;
  }

  // 4. Run inference
  final interpreter = Interpreter.fromAddress(address);
  final outputBuf   = Float32List(numChannels * numBoxes);
  interpreter.run(inputBuf.buffer, outputBuf.buffer);

  return {'output': outputBuf, 'dx': dx, 'dy': dy};
}

// ─── DetectorService ─────────────────────────────────────────────────────────
class DetectorService {
  Interpreter? _interpreter;
  List<String>? _labels;
  bool _isLoaded = false;
  int _inputSize = 640;

  Isolate?  _inferenceIsolate;
  SendPort? _inferSendPort;

  bool get isLoaded => _isLoaded;

  Future<void> load() async {
    final options = InterpreterOptions()..threads = 4;

    // Hardware acceleration: GPU delegate on Android (OpenGL), Metal on iOS.
    // NnApiDelegate was removed in tflite_flutter 0.10+; GpuDelegateV2 is the
    // recommended accelerator for Android. Falls back to CPU if unavailable.
    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        options.addDelegate(GpuDelegateV2());
        debugPrint('[Detector] GPU delegate enabled');
      } catch (_) {
        debugPrint('[Detector] Using CPU only');
      }
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      try {
        options.addDelegate(GpuDelegate());
        debugPrint('[Detector] Metal GPU delegate enabled');
      } catch (_) {
        debugPrint('[Detector] Using CPU only');
      }
    }

    _interpreter = await Interpreter.fromAsset(
      'assets/models/product_detection.tflite',
      options: options,
    );
    final labelData = await rootBundle.loadString('assets/models/labels.txt');
    _labels = labelData.trim().split('\n');

    final inShape = _interpreter!.getInputTensor(0).shape;
    _inputSize = inShape.length >= 3 ? inShape[1] : 640;

    _isLoaded = true;

    final outShape = _interpreter!.getOutputTensor(0).shape;
    debugPrint('[Detector] Input  shape : $inShape  (using $_inputSize×$_inputSize)');
    debugPrint('[Detector] Output shape : $outShape');
    debugPrint('[Detector] Labels count : ${_labels?.length}');

    // Spawn the persistent inference isolate (runs on its own dedicated OS thread).
    final initPort = ReceivePort();
    _inferenceIsolate = await Isolate.spawn(_inferenceIsolateEntry, initPort.sendPort);
    _inferSendPort = await initPort.first as SendPort;
    initPort.close();
    debugPrint('[Detector] Persistent inference isolate ready');
  }

  Future<void> dispose() async {
    _inferSendPort?.send(null); // shutdown signal
    _inferenceIsolate?.kill(priority: Isolate.immediate);
    _inferenceIsolate = null;
    _inferSendPort = null;
    _interpreter?.close();
    _isLoaded = false;
  }

  Future<DetectionResult> detect(CameraImage cameraImage) async {
    if (!_isLoaded || _interpreter == null || _inferSendPort == null) {
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

    final replyPort = ReceivePort();
    _inferSendPort!.send({
      'replyPort'    : replyPort.sendPort,
      'isJpeg'       : isJpeg,
      'isBGRA'       : isBGRA,
      'yBytes'       : cameraImage.planes[0].bytes,
      'yStride'      : cameraImage.planes[0].bytesPerRow,
      'uBytes'       : needsUV ? cameraImage.planes[1].bytes : Uint8List(0),
      'vBytes'       : needsUV ? cameraImage.planes[2].bytes : Uint8List(0),
      'uvStride'     : needsUV ? cameraImage.planes[1].bytesPerRow : 0,
      'uvPixelStride': needsUV ? (cameraImage.planes[1].bytesPerPixel ?? 1) : 1,
      'width'        : cameraImage.width,
      'height'       : cameraImage.height,
      'address'      : _interpreter!.address,
      'numChannels'  : numChannels,
      'numBoxes'     : numBoxes,
      'inputSize'    : _inputSize,
    });

    final result = await replyPort.first as Map<String, dynamic>;
    replyPort.close();
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
  List<DetectionBox> _parseNCHW(
      Float32List flat, int numBoxes, int numClasses, int dx, int dy) {
    final boxes   = <DetectionBox>[];
    final regionW = _inputSize - 2 * dx;
    final regionH = _inputSize - 2 * dy;
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
      if (bestScore >= _confThreshold) {
        final className = _labels?[bestClass] ?? 'unknown';
        debugPrint('[Detector NCHW] $className conf=$bestScore');
        boxes.add(DetectionBox(
          x: (cx - dx) / regionW, y: (cy - dy) / regionH,
          width: w / regionW,     height: h / regionH,
          classId: className,
          confidence: bestScore,
        ));
      } else if (bestClass == 2) {
        debugPrint('[Detector NCHW] BLOCKED: kohomba_soup conf=$bestScore (below 0.30)');
      }
    }
    return boxes;
  }

  // NHWC: outputFlat[box * numChannels + channel]
  List<DetectionBox> _parseNHWC(
      Float32List flat, int numBoxes, int numClasses, int dx, int dy) {
    final numCh   = numClasses + 4;
    final boxes   = <DetectionBox>[];
    final regionW = _inputSize - 2 * dx;
    final regionH = _inputSize - 2 * dy;
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
      if (bestScore >= _confThreshold) {
        final className = _labels?[bestClass] ?? 'unknown';
        debugPrint('[Detector NHWC] $className conf=$bestScore');
        boxes.add(DetectionBox(
          x: (cx - dx) / regionW, y: (cy - dy) / regionH,
          width: w / regionW,     height: h / regionH,
          classId: className,
          confidence: bestScore,
        ));
      } else if (bestClass == 2) {
        debugPrint('[Detector NHWC] BLOCKED: kohomba_soup conf=$bestScore (below 0.30)');
      }
    }
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
