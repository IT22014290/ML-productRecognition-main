import 'package:flutter/material.dart';

class ConfidenceBadge extends StatelessWidget {
  final double confidence;
  const ConfidenceBadge({super.key, required this.confidence});

  Color get _color {
    if (confidence >= 0.85) return const Color(0xFF4CAF50);
    if (confidence >= 0.65) return const Color(0xFFFF9800);
    return const Color(0xFFF44336);
  }

  String get _label {
    if (confidence >= 0.85) return 'High';
    if (confidence >= 0.65) return 'Medium';
    return 'Low';
  }

  @override
  Widget build(BuildContext context) {
    final pct = '${(confidence * 100).toStringAsFixed(1)}%';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        border: Border.all(color: _color, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            '$pct  $_label',
            style: TextStyle(
              color: _color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
