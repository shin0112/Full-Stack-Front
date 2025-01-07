import 'package:flutter/material.dart';

class CaffeineViewModal with ChangeNotifier {
  double get todayCaffeine => _todayCaffeine;
  double _todayCaffeine = 0;

  double get limitCaffeine => _limitCaffeine;
  final double _limitCaffeine = 400;

  num getLimitCaffeine(double weight) {
    const double maxCaffeinePerKg = 6.0;
    return weight * maxCaffeinePerKg.toInt();
  }

  void setTodayCaffeine(double caffeine) {
    _todayCaffeine += caffeine;
    notifyListeners();
  }

  CaffeineViewModal();
}
