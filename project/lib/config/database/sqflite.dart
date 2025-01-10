import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<String> getDatabasePath() async {
  var databasePath = await getDatabasesPath();
  return join(databasePath, 'coffhy.db');
}
