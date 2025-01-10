import 'package:project/data/datasource/record_datasource.dart';
import 'package:project/data/model/record.dart';

class RecordRepository {
  final RecordDatasource _recordDatasource = RecordDatasource();
  RecordRepository();

  Future<List<Record>> findAll() async {
    return await _recordDatasource.findAll();
  }
}
