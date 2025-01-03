import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconBox extends StatelessWidget {
  final IconData icon;

  const IconBox({
    super.key,
    this.icon = Icons.star,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        shape: BoxShape.circle,
      ),
      width: 35.sp,
      height: 35.sp,
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurface,
        size: 24.sp,
      ),
    );
  }
}
