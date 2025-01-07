import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/provider/index.dart';
import 'package:project/view/home/beverage_view.dart';
import 'package:project/view/home/hotlist_view.dart';
import 'package:project/view/home/today_caffeine_view.dart';
import 'package:project/widgets/bar/thin_bar.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620.sp,
      padding: EdgeInsets.symmetric(
        horizontal: 10.sp,
        vertical: 20.sp,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ThinBar(
            brown: true,
            icon: Icons.local_cafe_outlined,
            text: "오늘 마신 음료 추가하기",
            onTap: () {
              showModalBottomSheet<void>(
                showDragHandle: true,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                context: context,
                builder: (BuildContext context) {
                  return const BeverageView();
                },
              );
            },
          ),
          SizedBox(height: 12.sp),
          const TodayCaffeineView(),
          SizedBox(height: 12.sp),
          ThinBar(
            brown: false,
            icon: Icons.today,
            text: "지난 기록 보러가기",
            onTap: () => context.read<PageIndex>().setIndex(1),
          ),
          SizedBox(height: 12.sp),
          const HotlistView(),
        ],
      ),
    );
  }
}
