import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:project/config/database/sql_database.dart';
import 'package:project/data/model/record.dart';

const String tableRecord = 'record';
const String columnId = 'id';
const String columnBrandId = 'brandId';
const String columnCaffeine = 'caffeine';
const String columnTitle = 'title';
const String columnDetail = 'detail';
const String columnCreatedAt = 'createdAt';

class RecordDatasource {
  RecordDatasource();

  Future<Record> insert(Record record) async {
    var db = await SqlDatabase().database;
    record.id = await db.insert(
      tableRecord,
      record.toMap(),
    );
    return record;
  }

  Future<Record> findById(int id) async {
    var db = await SqlDatabase().database;
    List<Map> maps = await db.query(
      tableRecord,
      columns: [
        columnId,
        columnBrandId,
        columnCaffeine,
        columnTitle,
        columnDetail,
        columnCreatedAt
      ],
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      throw Exception("해당 기록 없음");
    }

    return Record.fromMap(maps.first as Map<String, Object?>);
  }

  Future<List<Record>> findAll() async {
    var db = await SqlDatabase().database;
    List<Map> maps = await db.query(
      tableRecord,
      columns: [
        columnId,
        columnBrandId,
        columnCaffeine,
        columnTitle,
        columnDetail,
        columnCreatedAt
      ],
    );

    if (maps.isEmpty) {
      return [];
    }

    return maps
        .map((record) => Record.fromMap(record as Map<String, Object?>))
        .toList();
  }

  Future<List<double>> findTodayCaffeine() async {
    var db = await SqlDatabase().database;
    var now = DateTime.now();

    var startOfDay = DateTime(now.year, now.month, now.day);
    var endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    String startOfDayStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(startOfDay);
    String endOfDayStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(endOfDay);

    List<Map> maps = await db.query(
      tableRecord,
      columns: [
        columnCaffeine,
      ],
      where: 'createdAt BETWEEN ? AND ?',
      whereArgs: [startOfDayStr, endOfDayStr],
    );
    if (maps.isEmpty) {
      log("오늘 기록 없음");
      return [];
    } else {
      return maps.map((map) => (map[columnCaffeine] as double)).toList();
    }
  }

  Future<int> delete(int id) async {
    var db = await SqlDatabase().database;
    return await db.delete(
      tableRecord,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Record record) async {
    var db = await SqlDatabase().database;
    return await db.update(
      tableRecord,
      record.toMap(),
      where: "$columnId = ?",
      whereArgs: [record.id],
    );
  }
}
