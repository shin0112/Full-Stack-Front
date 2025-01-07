import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:project/data/model/record.dart';
import 'package:project/data/repository/record_repository.dart';
import 'package:project/utils/get_hash_code.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModal with ChangeNotifier {
  final RecordRepository _recordRepository = RecordRepository();

  DateTime get focusedDay => _focusedDay;
  DateTime _focusedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  DateTime _selectedDay = DateTime.now();

  CalendarFormat get calendarFormat => _calendarFormat;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  List<Record> get selectedRecordList => _selectedRecordList;
  List<Record> _selectedRecordList = [];

  final recordList = LinkedHashMap<DateTime, List<Record>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  List<Record> getEventsForDay(DateTime day) {
    // Implementation example
    return recordList[day] ?? [];
  }

  void onDaySelected(DateTime focusedDay, DateTime selectedDay) {
    // _focusedDay = focusedDay;
    _selectedDay = selectedDay;
    notifyListeners();
  }

  void onFocusedDayChanged(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void onFormatChanged(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  CalendarViewModal() {
    _fetchData();
  }

  void _fetchData() async {
    _selectedRecordList = await _recordRepository.getRecordList();
    notifyListeners();
  }
}
