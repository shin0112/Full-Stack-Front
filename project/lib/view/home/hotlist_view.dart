import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/view/home/hotlist_view_model.dart';
import 'package:project/widgets/icon_box.dart';
import 'package:project/widgets/line.dart';
import 'package:provider/provider.dart';

class HotlistView extends StatelessWidget {
  // to do: 즐겨찾기 데이터 가져오기
  late HotlistViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<HotlistViewModel>(context);

    return Container(
      width: 328.sp,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // 상단
          _buildHotlistTopLabel(context),
          // 라인
          const HorizontalLine(width: 310),
          // 하단
          _buildHotlistBoxList(context),
        ],
      ),
    );
  }

  Widget _buildHotlistBoxList(BuildContext context) {
    final items = viewModel.items;

    return Container(
        width: 328.sp,
        padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
        child: GridView.count(
          crossAxisSpacing: 10.sp,
          mainAxisSpacing: 10.sp,
          crossAxisCount: 2,
          children: items
              .map((item) => HotlistBox(
                    caffeine: item.caffeine ?? 0.0,
                    detail: item.detail ?? "",
                    id: item.id ?? 0,
                    title: item.title ?? "",
                  ))
              .toList(),
        ));
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
    return Container(
      width: 147.sp,
      height: 68.sp,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
