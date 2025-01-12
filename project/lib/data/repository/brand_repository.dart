import 'package:flutter/services.dart';
import 'package:project/data/model/brand.dart';

class BrandRepository {
  BrandRepository();

  Future<Map<String, List<Brand>>> getBrandList() async {
    final List<String> category = ["커피숍", "편의점"];
    final String jsonString =
        await rootBundle.loadString('assets/dummy/brand.json');
    List<List<Brand>> data = await parseBrandFromJson(jsonString);

    return {for (int i = 0; i < category.length; i++) category[i]: data[i]};
  }

  Future<Map<int, String>> getBrandIdNameMap() async {
    Map<String, List<Brand>> categoryList = await getBrandList();
    Map<int, String> brandIdNameMap = {};

    for (var entry in categoryList.entries) {
      final List<Brand> brandList = entry.value;

      for (var brand in brandList) {
        brandIdNameMap[brand.id] = brand.name;
      }
    }

    return brandIdNameMap;
  }
}
