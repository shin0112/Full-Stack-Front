import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalLine extends StatelessWidget {
  final double width;

  const HorizontalLine({
    super.key,
    this.width = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: width == 1 ? 1 : width.sp,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        ),
      ),
    );
  }
}

class VerticalLine extends StatelessWidget {
  final double height;

  const VerticalLine({
    super.key,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height == 1 ? 1 : height.sp,
      width: 1,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        ),
      ),
    );
  }
}
