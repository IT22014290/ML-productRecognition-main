import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/products_database.dart';
import '../models/detection_result.dart';
import '../services/app_state.dart';
import '../services/detector_service.dart';
import '../widgets/bounding_box_painter.dart';
import 'product_detail_screen.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final DetectorService detector;

  const CameraScreen({
    super.key,
    required this.cameras,
    required this.detector,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  DetectionResult _result =
      const DetectionResult(boxes: [], inferenceTimeMs: 0);
  bool _isProcessing = false;
  bool _initialized  = false;
  String? _error;
  String? _detectionError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    if (widget.cameras.isEmpty) {
      setState(() => _error = 'No camera available on this device.');
      return;
    }
    _controller = CameraController(
      widget.cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    try {
      await _controller!.initialize();
      if (mounted) setState(() => _initialized = true);
      _controller!.startImageStream(_onCameraFrame);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  void _onCameraFrame(CameraImage image) async {
    if (_isProcessing || !widget.detector.isLoaded) return;
    _isProcessing = true;
    try {
      final result = await widget.detector.detect(image);
      if (mounted) {
        setState(() {
          _result = result;
          _detectionError = null;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _detectionError = e.toString());
    } finally {
      _isProcessing = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      final c = _controller;
      if (c != null && c.value.isInitialized) {
        _controller = null;
        setState(() => _initialized = false);
        c.stopImageStream()
            .catchError((_) {})
            .whenComplete(() => c.dispose());
      }
    } else if (state == AppLifecycleState.resumed) {
      if (_controller == null) _initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.stopImageStream();
    _controller?.dispose();
    super.dispose();
  }

  void _addToList() {
    final best    = _result.bestDetection;
    if (best == null) return;
    final product = findProduct(best.classId);
    if (product == null) return;

    final state = context.read<AppState>();
    state.addScannedItem(best.classId, best.confidence);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added: ${product.name(state.languageCode)}'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.watch<AppState>().languageCode;

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('Camera error: $_error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red)),
        ),
      );
    }
    if (!_initialized || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final productNames = <String, String>{
      for (final p in kProducts) p.id: p.name(langCode),
    };

    final best    = _result.bestDetection;
    final product = best != null ? findProduct(best.classId) : null;

    return Stack(
      children: [
        // ── Camera preview ──────────────────────────────────────────────────
        Positioned.fill(child: CameraPreview(_controller!)),

        // ── Bounding-box overlay ────────────────────────────────────────────
        Positioned.fill(
          child: CustomPaint(
            painter: BoundingBoxPainter(
              boxes: _result.boxes,
              languageCode: langCode,
              productNames: productNames,
            ),
          ),
        ),

        // ── Top hint bar ────────────────────────────────────────────────────
        Positioned(
          top: 0, left: 0, right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withValues(alpha: 0.55), Colors.transparent],
              ),
            ),
            child: const Text(
              'Point camera at a Sri Lankan supermarket product',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ),

        // ── Inference time ──────────────────────────────────────────────────
        if (_result.inferenceTimeMs > 0)
          Positioned(
            top: 44, right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${_result.inferenceTimeMs}ms',
                style:
                    const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ),
          ),

        // ── Detection error (debug) ─────────────────────────────────────────
        if (_detectionError != null)
          Positioned(
            top: 72, left: 8, right: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _detectionError!,
                style: const TextStyle(color: Colors.white, fontSize: 10),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

        // ── Bottom detection panel ──────────────────────────────────────────
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.transparent
                ],
              ),
            ),
            child: product != null
                ? _buildDetectionPanel(product, best!, langCode)
                : best != null
                    ? _buildUnknownPanel(best)
                    : _buildIdlePanel(),
          ),
        ),
      ],
    );
  }

  Widget _buildIdlePanel() => const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.center_focus_strong,
              color: Colors.white38, size: 36),
          SizedBox(height: 8),
          Text(
            'Point camera at any Sri Lankan supermarket product',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ],
      );

  Widget _buildUnknownPanel(DetectionBox best) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.help_outline, color: Colors.amber, size: 22),
            SizedBox(width: 8),
            Text('Product not in database',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 6),
          const Text(
            'Only Sri Lankan supermarket products are supported.\nTrain the model with more data to improve coverage.',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      );

  Widget _buildDetectionPanel(
      dynamic product, DetectionBox best, String langCode) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name(langCode),
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '${product.brand}  ·  ${product.category}  ·  ${product.price}',
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _addToList,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add to List'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
