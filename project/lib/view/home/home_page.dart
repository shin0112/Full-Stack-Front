import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/provider/index.dart';
import 'package:project/view/home/hotlist_view.dart';
import 'package:project/view/home/today_caffeine_view.dart';
import 'package:project/widgets/box/hotlist_box.dart';
import 'package:project/widgets/bar/thin_bar.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.sp,
        vertical: 20.sp,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ThinBar(
            brown: true,
            icon: Icons.local_cafe_outlined,
            text: "오늘 마신 음료 추가하기",
          ),
          SizedBox(height: 12.sp),
          TodayCaffeineView(),
          SizedBox(height: 12.sp),
          ThinBar(
            brown: false,
            icon: Icons.today,
            text: "지난 기록 보러가기",
            onTap: () => context.read<PageIndex>().setIndex(1),
          ),
          SizedBox(height: 12.sp),
          HotlistView(),
        ],
      ),
    );
  }
}
