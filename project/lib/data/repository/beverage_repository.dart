import 'package:flutter/services.dart';
import 'package:project/data/model/beverage.dart';

class BeverageRepository {
  BeverageRepository();

  Future<List<Beverage>> getBeverageList() async {
    final String jsonString =
        await rootBundle.loadString("assets/dummy/beverage.json");
    return parseBeverageFromJson(jsonString);
  }
}
