import 'dart:io';

import 'package:hive_ce_flutter/adapters.dart';
import 'package:project/config/database/hive_registrar.g.dart';
import 'package:project/data/model/user.dart';

@GenerateAdapters([AdapterSpec<User>()])
class HiveDatabase {
  static final HiveDatabase instance = HiveDatabase._instance();

  LazyBox get userBox => _userBox;
  late LazyBox _userBox;

  HiveDatabase._instance() {
    _initDatabase();
  }

  factory HiveDatabase() {
    return instance;
  }

  Future<void> _initDatabase() async {
    await Hive.initFlutter();
    _userBox = await Hive.openLazyBox('user');
  }
}
