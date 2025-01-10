import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CaffeineViewModal with ChangeNotifier {
  double get todayCaffeine => _todayCaffeine;
  double _todayCaffeine = 0;

  double get limitCaffeine => _limitCaffeine;
  final double _limitCaffeine = 400;

  String get date => _date;
  String _date = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());

  late Timer _midnightTimer;

  // todo: 나이, 키, 몸무게로 적정 카페인 구하기 함수

  void _setMidnightResetTimer() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = midnight.difference(now);

    _midnightTimer = Timer(durationUntilMidnight, () {
      _date = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());
      _setMidnightResetTimer();
    });
  }

  num getLimitCaffeine(double weight) {
    const double maxCaffeinePerKg = 6.0;
    return weight * maxCaffeinePerKg.toInt();
  }

  void setTodayCaffeine(double caffeine) {
    _todayCaffeine += caffeine;
    notifyListeners();
  }

  CaffeineViewModal() {
    _setMidnightResetTimer();
  }
}
