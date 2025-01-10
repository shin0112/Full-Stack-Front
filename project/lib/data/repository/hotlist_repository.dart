import 'package:project/data/datasource/hotlist_datasource.dart';
import 'package:project/data/model/hotlist.dart';

class HotlistRepository {
  final HotlistDatasource _hotlistDatasource = HotlistDatasource();

  HotlistRepository();

  Future<List<Hotlist>> findAll() async {
    return await _hotlistDatasource.findAll();
  }

  Future<Hotlist> insertHotlist(Hotlist hotlist) async {
    return await _hotlistDatasource.insert(hotlist);
  }

  Future<void> deleteHotlist(int id) async {
    await _hotlistDatasource.delete(id);
  }
}
