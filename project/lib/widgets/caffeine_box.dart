import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaffeineBox extends StatelessWidget {
  final double caffeine;

  const CaffeineBox({
    super.key,
    this.caffeine = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.sp,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: 2.sp,
        vertical: 4.sp,
      ),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        "${caffeine}mg",
        style:
            Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 12.sp),
      ),
    );
  }
}
