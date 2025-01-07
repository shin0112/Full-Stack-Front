import 'package:flutter/services.dart';
import 'package:project/data/model/brand.dart';

class BrandRepository {
  BrandRepository();

  Future<List<List<Brand>>> getBrandList() async {
    final String jsonString =
        await rootBundle.loadString('assets/dummy/brand.json');
    return parseBrandFromJson(jsonString);
  }
}
