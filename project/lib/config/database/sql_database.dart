import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  static final SqlDatabase instance = SqlDatabase._instance();

  Database? _database;

  SqlDatabase._instance() {
    _initDatabase();
  }

  factory SqlDatabase() {
    return instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    await _initDatabase();
    return _database!;
  }

  Future<void> _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'coffhy.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _databaseCreate,
    );
  }

  void _databaseCreate(Database db, int version) async {
    // Create Hotlist table
    await db.execute('''
    CREATE TABLE hotlist (
      id INTEGER AUTOINCREMENT NOT NULL PRIMARY KEY,
      name TEXT NOT NULL,
      detail TEXT NOT NULL,
      caffeine REAL NOT NULL
    );
  ''');

    // Create Record table
    db.execute('''
    CREATE TABLE record (
      id INTEGER AUTOINCREMENT NOT NULL PRIMARY KEY,
      brandId INTEGER,
      caffeine REAL NOT NULL,
      title TEXT NOT NULL,
      detail TEXT NOT NULL,
      createdAt TEXT NOT NULL
    );
  ''');
  }
}
