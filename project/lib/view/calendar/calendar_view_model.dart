import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/data/model/beverage.dart';
import 'package:project/data/model/hotlist.dart';
import 'package:project/data/model/record.dart';
import 'package:project/data/repository/brand_repository.dart';
import 'package:project/data/repository/record_repository.dart';
import 'package:project/utils/get_hash_code.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModel with ChangeNotifier {
  final RecordRepository _recordRepository = RecordRepository();
  final BrandRepository _brandRepository = BrandRepository();

  DateTime get focusedDay => _focusedDay;
  DateTime _focusedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  DateTime _selectedDay = DateTime.now();

  double get dailyTotalCaffeine => _dailyTotalCaffeine;
  double _dailyTotalCaffeine = 0.0;

  CalendarFormat get calendarFormat => _calendarFormat;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  List<Record> get selectedRecordList => _selectedRecordList;
  List<Record> _selectedRecordList = [];

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  RangeSelectionMode get rangeSelectionMode => _rangeSelectionMode;

  Map<int, String> get brandNameMap => _brandNameMap;
  Map<int, String> _brandNameMap = {};

  final recordList = LinkedHashMap<DateTime, List<Record>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarViewModel() {
    _fetchData();
    notifyListeners();
  }

  void _fetchData() async {
    log("fetch data start");
    final list = await _recordRepository.findAll();
    _brandNameMap = await _brandRepository.getBrandIdNameMap();
    log(_brandNameMap.toString());

    for (final record in list) {
      final key = record.createdAt;
      if (recordList.containsKey(key)) {
        recordList[key]!.add(record);
      } else {
        recordList[key] = [record];
      }
    }

    onDaySelected(_selectedDay, _focusedDay);
    _saveSelectedDayData();

    notifyListeners();
    log("fetch data end");
  }

  void _saveSelectedDayData() {
    _selectLogging();
    _selectedRecordList = getRecordForDay(_selectedDay);

    double sum = 0.0;
    for (Record record in _selectedRecordList) {
      sum += record.caffeine;
    }
    _dailyTotalCaffeine = sum;
  }

  void _selectLogging() {
    for (Record record in _selectedRecordList) {
      log(record.toString());
    }
    log("selected day: $_selectedDay");
  }

  List<Record> getRecordForDay(DateTime day) {
    return recordList[day] ?? [];
  }

  List<Record> getRecordListForRange(DateTime start, DateTime end) {
    final days = _daysInRange(start, end);
    return [
      for (final day in days) ...getRecordForDay(day),
    ];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    log("on day selected start");
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;

      _saveSelectedDayData();
    }

    notifyListeners();
    log("on day selected end");
  }

  void onPageChanged(DateTime focusedDay) {
    log("on page changed start");
    _focusedDay = focusedDay;

    _selectLogging();

    notifyListeners();
    log("on page changed end");
  }

  void onFormatChanged(CalendarFormat format) {
    log("on format changed start");
    if (_calendarFormat != format) {
      _calendarFormat = format;
    }

    _selectLogging();

    notifyListeners();
    log("on format changed end");
  }

  void saveRecordFromBeverage(Beverage beverage) async {
    final Record saved = await _recordRepository.insertRecord(
      Record(
        title: beverage.name,
        brandId: beverage.brandId,
        caffeine: beverage.caffeine,
        detail: "",
        createdAt: DateTime.now(),
      ),
    );

    final key = saved.createdAt;

    if (recordList.containsKey(key)) {
      recordList[key]!.add(saved);
    } else {
      recordList[key] = [saved];
    }

    notifyListeners();
  }

  void saveRecordFromHotlist(Hotlist hotlist) async {
    final Record saved = await _recordRepository.insertRecord(
      Record(
        caffeine: hotlist.caffeine,
        title: hotlist.name,
        detail: hotlist.detail,
        createdAt: DateTime.now(),
      ),
    );

    final key = saved.createdAt;

    if (recordList.containsKey(key)) {
      recordList[key]!.add(saved);
    } else {
      recordList[key] = [saved];
    }

    notifyListeners();
  }

  List<DateTime> _daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }
}
