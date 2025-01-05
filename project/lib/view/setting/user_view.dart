import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/data/model/user.dart';
import 'package:project/view/setting/user_view_model.dart';
import 'package:project/widgets/line.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, provider, child) {
        User user = provider.item.isEmpty ? User.testUser() : provider.item[0];

        return Container(
          width: 340.sp,
          height: 124.sp,
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildNameSection(context, user),
              SizedBox(height: 16.sp),
              _buildProfileSection(context, user),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNameSection(BuildContext context, User user) {
    return SizedBox(
      height: 40.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            user.name ?? "",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 22.sp),
          ),
          SizedBox(
            width: 40.sp,
            height: 40.sp,
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerHigh,
              child: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProfileItem(context, "나이", user.age.toString()),
        const VerticalLine(height: 40),
        _buildProfileItem(context, "키", user.height.toString()),
        const VerticalLine(height: 40),
        _buildProfileItem(context, "몸무게", user.weight.toString()),
      ],
    );
  }

  Widget _buildProfileItem(BuildContext context, String label, String content) {
    return SizedBox(
      width: 77.3.sp,
      height: 44.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          SizedBox(height: 4.sp),
          Text(
            content,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}

class UsernameView extends StatelessWidget {
  const UsernameView({super.key});

  // todo: user 값 처리
  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, provider, child) {
        User user = provider.item.isEmpty ? User.testUser() : provider.item[0];

        return Container(
          width: 316.sp,
          height: 40.sp,
          padding: EdgeInsets.symmetric(vertical: 6.sp),
          child: Column(
            children: [
              SizedBox(
                height: 28.sp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "계정",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 14.sp),
                    ),
                    Text(
                      user.username ?? "example@email.com",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 14.sp),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
