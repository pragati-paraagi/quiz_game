import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('coin.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE coins (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      coinCount INTEGER
    )
    ''');
  }

  Future<int> getCoinCount() async {
    final db = await instance.database;
    final result = await db.query('coins', limit: 1);
    if (result.isNotEmpty) {
      return result.first['coinCount'] as int;
    } else {
      // Initialize if no coins exist
      await addCoin(0); 
      return 0;
    }
  }

  Future<void> updateCoinCount(int newCount) async {
    final db = await instance.database;
    await db.update(
      'coins',
      {'coinCount': newCount},
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Future<void> addCoin(int coinCount) async {
    final db = await instance.database;
    await db.insert(
      'coins',
      {'coinCount': coinCount},
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
