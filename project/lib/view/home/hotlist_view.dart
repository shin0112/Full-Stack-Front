import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotlistView extends StatelessWidget {
  // to do: 즐겨찾기 데이터 가져오기

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328.sp,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        Icons.star,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 8.sp),
                    Text(
                      "즐겨찾기",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 14.sp),
                    ),
                  ],
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // todo: 즐겨찾기 추가 로직 작성
                  },
                  icon: Icon(
                    Icons.add,
                    size: 18.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: SizedBox(
                    height: 22.sp,
                    width: 28.sp,
                    child: Text(
                      "추가",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: 14.sp,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
