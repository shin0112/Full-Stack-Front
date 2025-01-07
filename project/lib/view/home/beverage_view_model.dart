import 'package:flutter/material.dart';
import 'package:project/data/model/beverage.dart';
import 'package:project/data/model/brand.dart';
import 'package:project/data/repository/beverage_repository.dart';
import 'package:project/data/repository/brand_repository.dart';

class BeverageViewModel with ChangeNotifier {
  final BrandRepository _brandRepository = BrandRepository();
  final BeverageRepository _beverageRepository = BeverageRepository();

  Map<String, List<Brand>> get brandList => _brandList;
  Map<String, List<Brand>> _brandList = {};

  List<Beverage> get beverageList => _beverageList;
  List<Beverage> _beverageList = [];

  int _selectedId = 0;
  int get selectedId => _selectedId;

  String _selectedBrand = "이디야";
  String get selectedBrand => _selectedBrand;

  void selectBrand(int id, String brand) {
    _selectedId = id;
    _selectedBrand = "";
    notifyListeners();
  }

  BeverageViewModel() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    _brandList = await _brandRepository.getBrandList();
    _beverageList = await _beverageRepository.getBeverageList();

    notifyListeners();
  }
}
