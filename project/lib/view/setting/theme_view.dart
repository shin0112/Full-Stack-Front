import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/view/setting/theme_view_model.dart';
import 'package:provider/provider.dart';

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyMedium =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp);

    return Consumer<ThemeViewModel>(
      builder: (context, provider, child) => Container(
        padding: EdgeInsets.symmetric(vertical: 6.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("화면 테마", style: bodyMedium),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  provider.themeMode == ThemeMode.light ? "라이트 모드" : "다크 모드",
                  style: bodyMedium,
                ),
                SizedBox(width: 10.sp),
                Switch(
                  value: provider.themeMode != ThemeMode.light,
                  onChanged: (bool value) {
                    provider.changeThemeMode();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
