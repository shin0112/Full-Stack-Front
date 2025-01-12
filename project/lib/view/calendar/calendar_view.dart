import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/view/calendar/calendar_view_model.dart';
import 'package:project/view/home/caffeine_view_modal.dart';
import 'package:project/widgets/caffeine_box.dart';
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
          _buildDateSection(
            context,
            provider.selectedDay,
            provider.dailyTotalCaffeine,
          ),
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
                  : _buildRecordList(
                      context,
                      provider,
                    )),
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
        markerDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildDateSection(
    BuildContext context,
    DateTime selectedDay,
    double dailyTotalCaffeine,
  ) {
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
          "${dailyTotalCaffeine}mg",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildRecordList(
    BuildContext context,
    CalendarViewModel provider,
  ) {
    TextStyle titleTextStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp);
    TextStyle brandTextStyle = Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 12.sp,
          color: Theme.of(context).colorScheme.primary,
        );

    return ListView.builder(
      itemCount: provider.selectedRecordList.length,
      itemBuilder: (context, index) {
        final record = provider.selectedRecordList[index];
        return Column(children: [
          Material(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onLongPress: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                          child: _buildDeleteItemDialog(
                        context,
                        provider,
                        record,
                      ))),
              child: Container(
                height: 44.sp,
                width: 320.sp,
                padding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(record.title, style: titleTextStyle),
                        SizedBox(width: 10.sp),
                        record.brandId == null
                            ? const SizedBox.shrink()
                            : Container(
                                width: 43.sp,
                                height: 24.sp,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  provider.brandNameMap[record.brandId] ?? "",
                                  style: brandTextStyle,
                                ),
                              ),
                      ],
                    ),
                    CaffeineBox(caffeine: record.caffeine)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.sp),
        ]);
      },
    );
  }

  Widget _buildDeleteItemDialog(
    BuildContext context,
    CalendarViewModel provider,
    Record record,
  ) {
    return Container(
      height: 120.sp,
      width: 340.sp,
      padding: EdgeInsets.all(20.sp),
      child: Column(
        children: [
          SizedBox(
            width: 300.sp,
            child: Text(
              "${record.title} 기록을 삭제하시겠습니까?",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 14.sp),
            ),
          ),
          SizedBox(height: 20.sp),
          SizedBox(
            width: 300.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 확인 버튼
                FilledButton(
                  onPressed: () {
                    if (record.createdAt.day == DateTime.now().day) {
                      context
                          .read<CaffeineViewModal>()
                          .minusTodayCaffeine(record.caffeine);
                    }
                    provider.deleteRecord(record);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "확인",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
                SizedBox(width: 6.sp),
                // 취소 버튼
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "취소",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
