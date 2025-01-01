import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/theme.dart';

class ThinBar extends StatefulWidget {
  final bool brown;
  final IconData icon;
  final String text;

  const ThinBar({
    super.key,
    this.brown = true, // 기본 아이콘 색
    this.icon = Icons.local_cafe_outlined,
    this.text = " ",
  });

  @override
  State<StatefulWidget> createState() => ThinBarState();
}

class ThinBarState extends State<ThinBar> {
  void _onTap() {}

  @override
  Widget build(BuildContext context) {
    final content = GestureDetector(
      onTap: _onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.sp),

        /// 내부 content
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 좌측
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    shape: BoxShape.circle,
                  ),
                  width: 35.sp,
                  height: 35.sp,
                  child: Icon(
                    widget.icon,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 8.sp),
                Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.brown
                        ? Theme.of(context).colorScheme.surfaceContainer
                        : Theme.of(context).colorScheme.onSurface,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),

            /// 우측
            Icon(
              Icons.keyboard_arrow_right,
              color: widget.brown
                  ? Theme.of(context).colorScheme.onInverseSurface
                  : Theme.of(context).colorScheme.onSurface,
              size: 24.sp,
            )
          ],
        ),
      ),
    );

    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        color: widget.brown
            ? MaterialTheme.coffee.seed
            : Theme.of(context).colorScheme.onPrimary,
      ),
      height: 55.sp,
      margin: EdgeInsets.symmetric(
        horizontal: 16.sp,
        vertical: 20.sp,
      ),
      child: content,
    );
  }
}
