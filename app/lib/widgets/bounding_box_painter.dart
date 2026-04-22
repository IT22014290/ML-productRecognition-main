import 'package:flutter/material.dart';
import '../models/detection_result.dart';

class BoundingBoxPainter extends CustomPainter {
  final List<DetectionBox> boxes;
  final String languageCode;
  final Map<String, String> productNames;

  BoundingBoxPainter({
    required this.boxes,
    required this.languageCode,
    required this.productNames,
  });

  static const List<Color> _colors = [
    Color(0xFF2196F3), Color(0xFF4CAF50), Color(0xFFF44336),
    Color(0xFFFF9800), Color(0xFF9C27B0), Color(0xFF00BCD4),
    Color(0xFFE91E63), Color(0xFF8BC34A),
  ];

  Color _colorFor(String classId) =>
      _colors[classId.hashCode.abs() % _colors.length];

  @override
  void paint(Canvas canvas, Size size) {
    for (final box in boxes) {
      final color = _colorFor(box.classId);
      final rect  = box.toPixelRect(size.width, size.height);
      final left = rect[0], top = rect[1], right = rect[2], bottom = rect[3];

      // Bounding box border
      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        Paint()
          ..color      = color
          ..style      = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );

      // Label
      final label      = productNames[box.classId] ?? box.classId;
      final confidence = '${(box.confidence * 100).toStringAsFixed(1)}%';
      final tp = TextPainter(
        text: TextSpan(
          text: '$label  $confidence',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final lh  = tp.height + 8;
      final lw  = tp.width  + 12;
      final lTop = top - lh < 0 ? top : top - lh;

      canvas.drawRect(Rect.fromLTWH(left, lTop, lw, lh), Paint()..color = color);
      tp.paint(canvas, Offset(left + 6, lTop + 4));
    }
  }

  @override
  bool shouldRepaint(BoundingBoxPainter old) =>
      old.boxes != boxes || old.languageCode != languageCode;
}
