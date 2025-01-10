import 'package:sqlite3/sqlite3.dart';

void setupDatabase(Database db) {
  // Create Hotlist table
  db.execute('''
    CREATE TABLE hotlist (
      id INTEGER NOT NULL PRIMARY KEY,
      userId INTEGER,
      name TEXT NOT NULL,
      detail TEXT NOT NULL,
      caffeine REAL NOT NULL
    );
  ''');

  // Create Record table
  db.execute('''
    CREATE TABLE record (
      id INTEGER NOT NULL PRIMARY KEY,
      userId INTEGER,
      brandId INTEGER,
      caffeine REAL NOT NULL,
      title TEXT NOT NULL,
      detail TEXT NOT NULL,
      createdAt TEXT NOT NULL
    );
  ''');
}
