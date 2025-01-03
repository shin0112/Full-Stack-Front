import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TodayCaffeineView extends StatefulWidget {
  final int limitCaffeine;

  const TodayCaffeineView({
    super.key,
    this.limitCaffeine = 400,
  });

  @override
  State<StatefulWidget> createState() => TodayCaffeineViewState();
}

// gif, 날짜, text, today 섭취한 카페인mg/ 개인마다 다른 카페인mg
class TodayCaffeineViewState extends State<TodayCaffeineView> {
  int todayCaffeine = 0;
  String date = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());
  late Timer _midnightTimer;

  void _setMidnightResetTimer() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = midnight.difference(now);

    _midnightTimer = Timer(durationUntilMidnight, () {
      setState(() {
        todayCaffeine = 0;
        date = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());
      });
      _setMidnightResetTimer();
    });
  }

  void addCaffeine(int amount) {
    setState(() {
      todayCaffeine += amount;
    });
  }

  @override
  void initState() {
    super.initState();
    _setMidnightResetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      height: 160.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 좌측
          Container(),

          // 우측
          Container(
            padding: EdgeInsets.only(
              left: 12.sp,
              right: 12.sp,
              top: 23.sp,
              bottom: 2.sp,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 상단 text container
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                        letterSpacing: 0.25,
                      ),
                    ),
                    Text(
                      "오늘 섭취한 카페인 양은?",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 24.sp),
                    ),
                  ],
                ),
                SizedBox(height: 4.sp),
                // 구분선
                Container(
                  height: 1.sp,
                  width: 282.sp,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.sp),
                // 카페인 text
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 75.sp,
                      child: Text(
                        todayCaffeine.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 64.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                          height: 1.2,
                          letterSpacing: 0.50,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.sp,
                    ),
                    Container(
                      height: 59.sp,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'mg/${widget.limitCaffeine}mg',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 32.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
