import 'dart:io';

import 'package:hive_ce_flutter/adapters.dart';
import 'package:project/config/database/hive_registrar.g.dart';
import 'package:project/data/model/user.dart';

class HiveDatabase {
  static final HiveDatabase instance = HiveDatabase._instance();
  HiveDatabase._instance();

  Box? _userBox;

  Future<Box> get userBox async {
    if (_userBox != null) return _userBox!;
    await _initDatabase();
    return _userBox!;
  }

  factory HiveDatabase() {
    return instance;
  }

  Future<void> _initDatabase() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox('user');

    if (await _userBox!.getAt(0) == null) {
      _userBox!.add(User());
    }

    final path = Directory.current.path;
    Hive
      ..init(path)
      ..registerAdapters();
  }
}
