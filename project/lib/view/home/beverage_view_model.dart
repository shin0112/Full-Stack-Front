import 'package:flutter/material.dart';
import 'package:project/data/model/brand.dart';
import 'package:project/data/repository/brand_repository.dart';

class BeverageViewModel with ChangeNotifier {
  final BrandRepository _brandRepository = BrandRepository();

  Map<String, List<Brand>> get brandList => _brandList;
  Map<String, List<Brand>> _brandList = {};

  int _selectedId = 0;
  int get selectedId => _selectedId;
  bool _isIceButton = true;
  bool get isIceButton => _isIceButton;

  void selectId(int id) {
    _selectedId = id;
    notifyListeners();
  }

  void selectTemp(bool isIceButton) {
    _isIceButton = isIceButton;
    notifyListeners();
  }

  BeverageViewModel() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    _brandList = await _brandRepository.getBrandList();

    notifyListeners();
  }
}
