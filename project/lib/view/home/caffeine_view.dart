import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';
import 'package:intl/intl.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/view/home/caffeine_view_modal.dart';
import 'package:project/widgets/line.dart';
import 'package:provider/provider.dart';

class TodayCaffeineView extends StatefulWidget {
  const TodayCaffeineView({super.key});

  @override
  State<StatefulWidget> createState() => TodayCaffeineViewState();
}

class TodayCaffeineViewState extends State<TodayCaffeineView> {
  String date = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());
  late Timer _midnightTimer;

  // to do: 나이, 키, 몸무게로 적정 카페인 구하기 함수

  void _setMidnightResetTimer() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = midnight.difference(now);

    _midnightTimer = Timer(durationUntilMidnight, () {
      setState(() {
        date = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());
      });
      _setMidnightResetTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    _setMidnightResetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CaffeineViewModal>(
      builder: (context, provider, child) {
        double progressRatio = provider.todayCaffeine / provider.limitCaffeine;
        progressRatio = progressRatio > 1.0 ? 1.0 : progressRatio;

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          height: 160.sp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 좌측
              Container(
                  width: 22.sp,
                  height: 160.sp,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (progressRatio < 1.0 && provider.todayCaffeine > 0)
                        Gif(
                          autostart: Autostart.loop,
                          image: const AssetImage("assets/images/curve.gif"),
                        ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        height: 160.sp * progressRatio,
                        decoration: BoxDecoration(
                          color: MaterialTheme.coffee.seed,
                          borderRadius: provider.todayCaffeine >= 400
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                )
                              : const BorderRadius.only(
                                  bottomLeft: Radius.circular(12)),
                        ),
                      ),
                    ],
                  )),

              // 우측
              Container(
                padding: EdgeInsets.only(
                  left: 18.sp,
                  right: 18.sp,
                  top: 23.sp,
                  bottom: 2.sp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 상단 text container
                    _buildTopTextSection(context),
                    SizedBox(height: 4.sp),
                    const HorizontalLine(width: 282),
                    SizedBox(height: 4.sp),
                    // 카페인 text
                    _buildCaffeineSection(
                      context,
                      provider.todayCaffeine.toInt(),
                      provider.limitCaffeine.toInt(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopTextSection(BuildContext context) {
    TextStyle dateTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.secondary,
      fontSize: 14.sp,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      height: 1.2,
      letterSpacing: 0.25,
    );
    TextStyle questionTextStyle =
        Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 24.sp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(date, style: dateTextStyle),
        Text("오늘 섭취한 카페인 양은?", style: questionTextStyle),
      ],
    );
  }

  Widget _buildCaffeineSection(
    BuildContext context,
    int todayCaffeine,
    int limitCaffeine,
  ) {
    TextStyle todayCaffeineTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: 64.sp,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w900,
      height: 1.2,
      letterSpacing: 0.50,
    );
    TextStyle limitCaffeineTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: 32.sp,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      height: 1.2,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 75.sp,
          alignment: Alignment.bottomRight,
          child: Text(todayCaffeine.toString(), style: todayCaffeineTextStyle),
        ),
        SizedBox(width: 2.sp),
        Container(
          height: 59.sp,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('mg/${limitCaffeine}mg', style: limitCaffeineTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}
