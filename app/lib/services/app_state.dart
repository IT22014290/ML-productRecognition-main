import 'package:flutter/material.dart';
import '../models/scanned_item.dart';
import 'database_service.dart';

class AppState extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  List<ScannedItem> _scannedItems = [];
  String _languageCode = 'en';

  List<ScannedItem> get scannedItems => _scannedItems;
  String get languageCode => _languageCode;

  Future<void> loadScannedItems() async {
    _scannedItems = await _dbService.getAll();
    notifyListeners();
  }

  Future<void> addScannedItem(String productId, double confidence) async {
    final item = ScannedItem(
      productId: productId,
      confidence: confidence,
      scannedAt: DateTime.now(),
    );
    final saved = await _dbService.insert(item);
    _scannedItems.insert(0, saved);
    notifyListeners();
  }

  Future<void> deleteItem(int id) async {
    await _dbService.delete(id);
    _scannedItems.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  Future<void> clearAll() async {
    await _dbService.clearAll();
    _scannedItems.clear();
    notifyListeners();
  }

  void setLanguage(String langCode) {
    _languageCode = langCode;
    notifyListeners();
  }
}
