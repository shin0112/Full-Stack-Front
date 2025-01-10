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

  int _recordId = 1;

  DateTime get focusedDay => _focusedDay;
  DateTime _focusedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  DateTime _selectedDay = DateTime.now();

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
    getRecordForDay(_selectedDay);
  }

  List<Record> getRecordForDay(DateTime day) {
    _selectedRecordList = recordList[day] ?? [];
    return _selectedRecordList;
  }

  List<Record> getRecordListForRange(DateTime start, DateTime end) {
    final days = _daysInRange(start, end);
    return [
      for (final day in days) ...getRecordForDay(day),
    ];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    }

    getRecordForDay(selectedDay);
    notifyListeners();
  }

  void onPageChanged(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void onFormatChanged(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  void _fetchData() async {
    final list = await _recordRepository.getRecordList();
    _recordId = list.last.id;
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

    notifyListeners();
  }

  void saveRecordFromBeverage(Beverage beverage, int? userId) {
    final Record newRecord = Record(
      id: ++_recordId,
      userId: userId,
      title: beverage.name,
      brandId: beverage.brandId,
      caffeine: beverage.caffeine,
      detail: "",
      createdAt: DateTime.now(),
    );

    final key = newRecord.createdAt;

    if (recordList.containsKey(key)) {
      recordList[key]!.add(newRecord);
    } else {
      recordList[key] = [newRecord];
    }

    getRecordForDay(key);
    notifyListeners();
  }

  void saveRecordFromHotlist(Hotlist hotlist, int? userId) {
    final Record newRecord = Record(
      id: ++_recordId,
      userId: userId,
      caffeine: hotlist.caffeine,
      title: hotlist.name,
      detail: hotlist.detail,
      createdAt: DateTime.now(),
    );

    final key = newRecord.createdAt;

    if (recordList.containsKey(key)) {
      recordList[key]!.add(newRecord);
    } else {
      recordList[key] = [newRecord];
    }

    getRecordForDay(key);
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
