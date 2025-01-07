import 'package:flutter/material.dart';
import 'package:project/data/model/brand.dart';
import 'package:project/data/repository/brand_repository.dart';

class BeverageViewModel with ChangeNotifier {
  final BrandRepository _brandRepository = BrandRepository();

  List<List<Brand>> get brandList => _brandList;
  List<List<Brand>> _brandList = [];

  BeverageViewModel() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    _brandList = await _brandRepository.getBrandList();
    notifyListeners();
  }
}
