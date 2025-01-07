import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/view/calendar/calendar_view_model.dart';
import 'package:project/widgets/line.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:project/data/model/record.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarViewModel>(builder: (context, provider, child) {
      return Column(
        children: [
          _buildCalendar(context, provider),
          SizedBox(height: 10.sp),
          HorizontalLine(width: 320.sp),
          SizedBox(height: 10.sp),
          _buildDateSection(context, provider.selectedDay),
          SizedBox(height: 10.sp),
          HorizontalLine(width: 320.sp),
          SizedBox(height: 10.sp),
          Expanded(
            child: provider.selectedRecordList.isEmpty
                ? Center(
                    child: Text(
                      "기록이 없습니다.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : ListView.builder(
                    itemCount: provider.selectedRecordList.length,
                    itemBuilder: (context, index) {
                      final record = provider.selectedRecordList[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print(record), // 기록 출력
                          title: Text(record.title), // Record 클래스의 필드
                          subtitle: Text(record.detail ?? ""), // 선택적 필드
                        ),
                      );
                    },
                  ),
          ),
        ],
      );
    });
  }

  Widget _buildCalendar(BuildContext context, CalendarViewModel provider) {
    return TableCalendar<Record>(
      focusedDay: provider.focusedDay,
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2025, 12, 31),
      selectedDayPredicate: (day) => isSameDay(provider.selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) =>
          provider.onDaySelected(selectedDay, focusedDay),
      calendarFormat: provider.calendarFormat,
      onFormatChanged: (format) => provider.onFormatChanged(format),
      onPageChanged: (focusedDay) => provider.onPageChanged(focusedDay),
      eventLoader: (day) => provider.getRecordForDay(day),
      rangeSelectionMode: provider.rangeSelectionMode,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        selectedDecoration: BoxDecoration(
          color: MaterialTheme.coffee.seed,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: MaterialTheme.coffee.seed.withOpacity(0.7),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildDateSection(BuildContext context, DateTime selectedDay,
      [double caffeineSum = 0.0]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16.sp,
              ),
        ),
        Text(
          "${caffeineSum}mg",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 16.sp),
        ),
      ],
    );
  }
}
