import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/data/model/user.dart';
import 'package:project/view/setting/user_view_model.dart';
import 'package:project/widgets/line.dart';
import 'package:project/widgets/section/dialog_button_section.dart';
import 'package:provider/provider.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, provider, child) {
        User user = provider.user;

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
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const UserUpdateDialog(),
              ),
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
        User user = provider.user;

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

class UserUpdateDialog extends StatefulWidget {
  const UserUpdateDialog({super.key});

  @override
  State<StatefulWidget> createState() => UserUpdateDialogState();
}

class UserUpdateDialogState extends State<UserUpdateDialog> {
  @override
  Widget build(BuildContext context) {
    final User user = context.read<UserViewModel>().user;
    String name = user.name ?? "";
    int age = user.age ?? 20;
    double weight = user.weight ?? 168.0;
    double height = user.height ?? 62.7;

    return Dialog(
      child: Container(
        width: 340.sp,
        height: 388.sp,
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: [
            Container(
              height: 20.sp,
              alignment: Alignment.centerLeft,
              child: Text(
                "개인정보 수정",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 20.sp),
            TextField(
              onChanged: (value) => {name = value},
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "이름",
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.cancel_outlined),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => {age = int.parse(value)},
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "나이",
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.cancel_outlined),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => {height = double.parse(value)},
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "키 (cm)",
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.cancel_outlined),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => {weight = double.parse(value)},
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "몸무게 (kg)",
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.cancel_outlined),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            Container(
              width: 300.sp,
              height: 40.sp,
              alignment: Alignment.centerRight,
              child: DialogButtonSection(
                onPressConfirm: () {
                  context
                      .read<UserViewModel>()
                      .updateData(name, age, height, weight);
                  Navigator.pop(context);
                },
                onPressCancel: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
