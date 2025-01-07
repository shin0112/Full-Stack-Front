import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:project/data/model/record.dart';
import 'package:project/utils/get_hash_code.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModal with ChangeNotifier {
  DateTime get focusedDay => _focusedDay;
  DateTime _focusedDay = DateTime.now();

  DateTime get selectedDay => _selectedDay;
  DateTime _selectedDay = DateTime.now();

  CalendarFormat get calendarFormat => _calendarFormat;
  CalendarFormat _calendarFormat = CalendarFormat.month;

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

  CalendarViewModal();
}
