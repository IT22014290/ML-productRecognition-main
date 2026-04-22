import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/scanned_item.dart';

class DatabaseService {
  static Database? _db;

  Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path   = join(dbPath, 'scanned_products.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE scanned_items (
            id          INTEGER PRIMARY KEY AUTOINCREMENT,
            product_id  TEXT    NOT NULL,
            confidence  REAL    NOT NULL,
            scanned_at  TEXT    NOT NULL
          )
        ''');
      },
    );
  }

  Future<ScannedItem> insert(ScannedItem item) async {
    final database = await db;
    final id = await database.insert('scanned_items', item.toMap());
    return item.copyWith(id: id);
  }

  Future<List<ScannedItem>> getAll() async {
    final database = await db;
    final maps = await database.query(
      'scanned_items',
      orderBy: 'scanned_at DESC',
    );
    return maps.map(ScannedItem.fromMap).toList();
  }

  Future<void> delete(int id) async {
    final database = await db;
    await database.delete('scanned_items', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearAll() async {
    final database = await db;
    await database.delete('scanned_items');
  }
}
