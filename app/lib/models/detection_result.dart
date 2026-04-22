class DetectionBox {
  final double x;       // center x (normalized 0-1)
  final double y;       // center y (normalized 0-1)
  final double width;   // normalized 0-1
  final double height;  // normalized 0-1
  final String classId;
  final double confidence;

  const DetectionBox({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.classId,
    required this.confidence,
  });

  /// Returns [left, top, right, bottom] in pixels.
  List<double> toPixelRect(double screenW, double screenH) {
    final left   = (x - width  / 2) * screenW;
    final top    = (y - height / 2) * screenH;
    final right  = (x + width  / 2) * screenW;
    final bottom = (y + height / 2) * screenH;
    return [left, top, right, bottom];
  }
}

class DetectionResult {
  final List<DetectionBox> boxes;
  final int inferenceTimeMs;

  const DetectionResult({
    required this.boxes,
    required this.inferenceTimeMs,
  });

  bool get hasDetections => boxes.isNotEmpty;

  DetectionBox? get bestDetection => boxes.isEmpty
      ? null
      : boxes.reduce((a, b) => a.confidence > b.confidence ? a : b);
}
