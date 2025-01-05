import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/view/setting/user_view.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620.sp,
      width: 360.sp,
      padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserView(),
          SizedBox(height: 10.sp),
          Text(
            "설정",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 10.sp),
          _buildSettingContainer(context),
        ],
      ),
    );
  }

  Widget _buildSettingContainer(BuildContext context) {
    return Container(
      width: 340.sp,
      height: 412.sp,
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [UsernameView()],
      ),
    );
  }
}
