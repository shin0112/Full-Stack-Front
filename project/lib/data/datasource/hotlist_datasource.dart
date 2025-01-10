import 'package:project/config/database/sql_database.dart';
import 'package:project/data/model/hotlist.dart';

const String tableHotlist = 'hotlist';
const String columnId = 'id';
const String columnName = 'name';
const String columnDetail = 'detail';
const String columnCaffeine = 'caffeine';

class HotlistDatasource {
  HotlistDatasource();

  Future<Hotlist> insert(Hotlist hotlist) async {
    var db = await SqlDatabase().database;
    hotlist.id = await db.insert(
      tableHotlist,
      hotlist.toMap(),
    );
    return hotlist;
  }

  Future<Hotlist> findById(int id) async {
    var db = await SqlDatabase().database;
    List<Map> maps = await db.query(
      tableHotlist,
      columns: [columnId, columnName, columnDetail, columnCaffeine],
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      throw Exception("해당 즐겨찾기 없음");
    }

    return Hotlist.fromMap(maps.first as Map<String, Object?>);
  }

  Future<List<Hotlist>> findAll() async {
    var db = await SqlDatabase().database;
    List<Map> maps = await db.query(
      tableHotlist,
      columns: [columnId, columnName, columnDetail, columnCaffeine],
    );

    if (maps.isEmpty) {
      throw Exception("해당 즐겨찾기 없음");
    }

    return maps
        .map((hotlist) => Hotlist.fromMap(hotlist as Map<String, Object?>))
        .toList();
  }

  Future<int> delete(int id) async {
    var db = await SqlDatabase().database;
    return await db.delete(
      tableHotlist,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Hotlist hotlist) async {
    var db = await SqlDatabase().database;
    return await db.update(
      tableHotlist,
      hotlist.toMap(),
      where: "$columnId = ?",
      whereArgs: [hotlist.id],
    );
  }

  Future close() async {
    var db = await SqlDatabase().database;
    db.close();
  }
}
