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

  Future<String> getBrandNameById(int id) async {
    Map<String, List<Brand>> categoryList = await getBrandList();

    late String name;

    categoryList.entries.map((entry) {
      final List<Brand> brandList = entry.value;

      for (int i = 0; i < brandList.length; i++) {
        if (brandList[i].id == id) {
          name = brandList[i].name;
        }
      }
    });

    return Future<String>.value(name);
  }
}
