import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/data/model/user.dart';
import 'package:project/view/setting/user_view_model.dart';
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
              SizedBox(
                height: 28.sp,
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

class UsernameView extends StatelessWidget {
  const UsernameView({super.key});

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
