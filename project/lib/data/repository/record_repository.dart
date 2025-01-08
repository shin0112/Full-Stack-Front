import 'package:flutter/services.dart';
import 'package:project/data/model/record.dart';

class RecordRepository {
  RecordRepository();

  Future<List<Record>> getRecordList() async {
    final String jsonString =
        await rootBundle.loadString("assets/dummy/record.json");
    return parseRecordFromJson(jsonString);
  }
}
