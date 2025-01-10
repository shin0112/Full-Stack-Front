import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// todo: 나이, 키, 몸무게로 적정 카페인 구하기 함수
class CaffeineViewModal with ChangeNotifier {
  double get todayCaffeine => _todayCaffeine;
  double _todayCaffeine = 0;

  double get limitCaffeine => _limitCaffeine;
  final double _limitCaffeine = 400;

  String get date => _date;
  String _date = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());

  late Timer _midnightTimer;

  CaffeineViewModal() {
    _setMidnightResetTimer();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  void _setMidnightResetTimer() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = midnight.difference(now);

    _midnightTimer = Timer(durationUntilMidnight, () {
      final newDate = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());

      if (newDate != _date) {
        _date = newDate;
        notifyListeners();
      }

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

  void cancelTimer() {
    if (_midnightTimer.isActive) {
      _midnightTimer.cancel();
    }
  }
}
