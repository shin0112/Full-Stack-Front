import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/data/repository/record_repository.dart';

// todo: 나이, 키, 몸무게로 적정 카페인 구하기 함수
class CaffeineViewModal with ChangeNotifier {
  final RecordRepository _recordRepository = RecordRepository();

  double get todayCaffeine => _todayCaffeine;
  double _todayCaffeine = 0;

  double get limitCaffeine => _limitCaffeine;
  final double _limitCaffeine = 400;

  String get date => _date;
  String _date = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());

  late Timer _midnightTimer;

  CaffeineViewModal() {
    _fetchData();
    _setMidnightResetTimer();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  void _fetchData() async {
    List<double> caffeineList = await _recordRepository.findTodayCaffeine();

    for (double caffeine in caffeineList) {
      _todayCaffeine += caffeine;
    }

    notifyListeners();
  }

  void _setMidnightResetTimer() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = midnight.difference(now);

    log("자정까지 시간: ${durationUntilMidnight.toString()}");

    _midnightTimer = Timer(durationUntilMidnight, () {
      log("타이머 리셋");
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

  void plusTodayCaffeine(double caffeine) {
    _todayCaffeine += caffeine;
    notifyListeners();
  }

  void minusTodayCaffeine(double caffeine) {
    _todayCaffeine -= caffeine;

    if (_todayCaffeine < 0) {
      _todayCaffeine = 0;
    }

    notifyListeners();
  }

  void cancelTimer() {
    if (_midnightTimer.isActive) {
      _midnightTimer.cancel();
    }
  }
}
