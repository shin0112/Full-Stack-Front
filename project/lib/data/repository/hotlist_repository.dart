import 'package:flutter/services.dart';
import 'package:project/data/model/hotlist.dart';

class HotlistRepository {
  HotlistRepository();

  // todo: 실제 data 연결하기
  Future<List<Hotlist>> getItems() async {
    final String jsonString =
        await rootBundle.loadString('assets/dummy/hotlist.json');
    return parseHotlistFromJson(jsonString);
  }
}
