import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
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

  CalendarFormat get calendarFormat => _calendarFormat;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  List<Record> get selectedRecordList => _selectedRecordList;
  List<Record> _selectedRecordList = [];

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  RangeSelectionMode get rangeSelectionMode => _rangeSelectionMode;

  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  Map<int, String> get brandNameMap => _brandNameMap;
  Map<int, String> _brandNameMap = {};

  final recordList = LinkedHashMap<DateTime, List<Record>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  // int getHashCode(DateTime key) {
  //   return key.day * 1000000 + key.month * 10000 + key.year;
  // }

  List<Record> getRecordForDay(DateTime day) {
    // Implementation example
    return recordList[day] ?? [];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    }

    _selectedRecordList = getRecordForDay(selectedDay);
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

  CalendarViewModel() {
    _fetchData();
  }

  void _fetchData() async {
    _selectedRecordList = await _recordRepository.getRecordList();
    _brandNameMap = await _brandRepository.getBrandIdNameMap();
    log(_brandNameMap.toString());
    notifyListeners();
  }
}
