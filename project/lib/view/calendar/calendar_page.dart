import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/view/calendar/calendar_view.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.sp,
      height: 620.sp,
      padding: EdgeInsets.only(
        left: 10.sp,
        right: 10.sp,
        top: 20.sp,
      ),
      child: Container(
        width: 340.sp,
        height: 600.sp,
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: const CalendarView(),
      ),
    );
  }
}
