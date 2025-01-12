import 'package:hive_ce_flutter/adapters.dart';
import 'package:project/config/database/hive_registrar.g.dart';
import 'package:project/data/model/user.dart';

class HiveDatabase {
  static final HiveDatabase instance = HiveDatabase._instance();
  HiveDatabase._instance();

  Box<User>? _userBox;

  Future<Box<User>> get userBox async {
    if (_userBox != null) return _userBox!;
    await _initDatabase();
    return _userBox!;
  }

  factory HiveDatabase() {
    return instance;
  }

  Future<void> _initDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapters();

    // await Hive.deleteBoxFromDisk('user');
    _userBox = await Hive.openBox<User>('user');

    if (_userBox!.isEmpty) {
      _userBox!.add(User());
    }
  }
}
