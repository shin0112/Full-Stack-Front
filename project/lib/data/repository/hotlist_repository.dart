import 'package:flutter/services.dart';
import 'package:project/data/model/hotlist.dart';

class HotlistRepository {
  HotlistRepository();

  Future<List<Hotlist>> getItems() async {
    final String jsonString =
        await rootBundle.loadString('assets/dummy/hotlist.json');
    return parseHotlistFromJson(jsonString);
  }
}
