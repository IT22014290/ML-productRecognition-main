class ScannedItem {
  final int? id;
  final String productId;
  final double confidence;
  final DateTime scannedAt;

  const ScannedItem({
    this.id,
    required this.productId,
    required this.confidence,
    required this.scannedAt,
  });

  ScannedItem copyWith({int? id}) => ScannedItem(
        id: id ?? this.id,
        productId: productId,
        confidence: confidence,
        scannedAt: scannedAt,
      );

  Map<String, dynamic> toMap() => {
        if (id != null) 'id': id,
        'product_id': productId,
        'confidence': confidence,
        'scanned_at': scannedAt.toIso8601String(),
      };

  static ScannedItem fromMap(Map<String, dynamic> map) => ScannedItem(
        id: map['id'] as int?,
        productId: map['product_id'] as String,
        confidence: (map['confidence'] as num).toDouble(),
        scannedAt: DateTime.parse(map['scanned_at'] as String),
      );
}
