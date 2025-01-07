import 'package:flutter/material.dart';
import 'package:project/view/calendar/calendar_view_model.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarViewModal>(builder: (context, provider, child) {
      return TableCalendar(
        focusedDay: provider.focusedDay,
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2025, 12, 31),
        selectedDayPredicate: (day) => isSameDay(provider.selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) =>
            provider.onDaySelected(focusedDay, selectedDay),
        calendarFormat: provider.calendarFormat,
        onFormatChanged: (format) => provider.onFormatChanged(format),
        onPageChanged: (focusedDay) => provider.onFocusedDayChanged(focusedDay),
      );
    });
  }
}
