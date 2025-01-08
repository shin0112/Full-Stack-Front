import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/data/model/hotlist.dart';
import 'package:project/utils/add_object_postposition.dart';
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
                  hotlist: item,
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
  final Hotlist hotlist;

  const HotlistBox({
    super.key,
    required this.id,
    required this.hotlist,
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
                hotlist.title,
                style: titleStyle,
              ),
              GestureDetector(
                // todo: tap 시 삭제 모달 로직 작성
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    insetPadding: EdgeInsets.symmetric(vertical: 300.sp),
                    child: _buildDeleteItemModal(context, hotlist),
                  ),
                ),
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
                  hotlist.detail,
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
                  "${hotlist.caffeine}mg",
                  style: contextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteItemModal(
    BuildContext context,
    Hotlist hotlist,
  ) {
    return Container(
      height: 120.sp,
      width: 340.sp,
      padding: EdgeInsets.all(20.sp),
      child: Column(
        children: [
          SizedBox(
            width: 300.sp,
            child: Text(
              "${addObjectPostposition(hotlist.title)} 삭제하시겠습니까?",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 14.sp),
            ),
          ),
          SizedBox(height: 20.sp),
          SizedBox(
            width: 300.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 확인 버튼
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context.watch<HotlistViewModel>().deleteHotList(hotlist);
                  },
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
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "취소",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
