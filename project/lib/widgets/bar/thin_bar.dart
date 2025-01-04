import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/widgets/icon_box.dart';

class ThinBar extends StatefulWidget {
  final bool brown;
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ThinBar({
    super.key,
    this.brown = true,
    this.icon = Icons.local_cafe_outlined,
    this.text = " ",
    this.onTap,
  });

  @override
  State<StatefulWidget> createState() => ThinBarState();
}

class ThinBarState extends State<ThinBar> {
  @override
  Widget build(BuildContext context) {
    final content = Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12.sp),

      /// 내부 content
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 좌측
          Row(
            children: [
              IconBox(icon: widget.icon),
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
    );

    return SizedBox(
      height: 55.sp,
      child: Material(
        borderRadius: BorderRadius.circular(12.sp),
        color: widget.brown
            ? MaterialTheme.coffee.seed
            : Theme.of(context).colorScheme.onSecondary,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.sp),
          onTap: widget.onTap,
          child: content,
        ),
      ),
    );
  }
}
