import 'package:project/data/datasource/record_datasource.dart';
import 'package:project/data/model/record.dart';

class RecordRepository {
  final RecordDatasource _recordDatasource = RecordDatasource();

  RecordRepository();

  Future<List<Record>> findAll() async {
    return await _recordDatasource.findAll();
  }

  Future<List<double>> findTodayCaffeine() async {
    return await _recordDatasource.findTodayCaffeine();
  }

  Future<Record> insertRecord(Record record) async {
    return await _recordDatasource.insert(record);
  }

  Future<void> deleteRecord(int id) async {
    await _recordDatasource.delete(id);
  }
}
