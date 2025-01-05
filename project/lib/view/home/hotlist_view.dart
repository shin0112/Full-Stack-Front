import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/data/model/hotlist.dart';
import 'package:project/view/home/hotlist_view_model.dart';
import 'package:project/widgets/icon_box.dart';
import 'package:project/widgets/line.dart';
import 'package:provider/provider.dart';

class HotlistView extends StatelessWidget {
  const HotlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HotlistViewModel>(
      builder: (context, provider, child) {
        return Container(
          height: 226.sp,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // 상단
              _buildHotlistTopLabel(context),
              // 라인
              const HorizontalLine(width: 310),
              // 하단
              _buildHotlistBoxList(provider.items),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHotlistBoxList(List<Hotlist> items) {
    return Container(
      height: 166.sp,
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisSpacing: 10.sp,
        mainAxisSpacing: 10.sp,
        crossAxisCount: 2,
        childAspectRatio: 153 / 68,
        children: items
            .map((item) => HotlistBox(
                  id: item.id,
                  title: item.title,
                  detail: item.detail,
                  caffeine: item.caffeine,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildHotlistTopLabel(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const IconBox(icon: Icons.star),
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
                borderRadius: const BorderRadius.all(Radius.circular(100)),
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
    );
  }
}

class HotlistBox extends StatelessWidget {
  final int id;
  final String title;
  final String detail;
  final double caffeine;

  const HotlistBox({
    super.key,
    this.id = 0,
    this.title = "",
    this.detail = "",
    this.caffeine = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14.sp);
    final contextStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          fontSize: 12.sp,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );

    return Container(
      width: 153.sp,
      height: 68.sp,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              GestureDetector(
                // todo: tap 시 삭제 모달 로직 작성
                onTap: () {},
                child: Icon(
                  Icons.cancel_outlined,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 74.sp,
                child: Text(
                  detail,
                  style: contextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 2.sp),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "${caffeine}mg",
                  style: contextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
