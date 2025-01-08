import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogButtonSection extends StatelessWidget {
  final VoidCallback onPressConfirm;
  final VoidCallback onPressCancel;

  const DialogButtonSection({
    super.key,
    required this.onPressCancel,
    required this.onPressConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // 확인 버튼
        FilledButton(
          onPressed: onPressConfirm,
          child: Text(
            "확인",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        SizedBox(width: 6.sp),
        // 취소 버튼
        OutlinedButton(
          onPressed: onPressCancel,
          child: Text(
            "취소",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
      ],
    );
  }
}
