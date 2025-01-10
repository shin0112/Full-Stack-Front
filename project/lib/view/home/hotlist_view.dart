import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/data/model/hotlist.dart';
import 'package:project/utils/add_object_postposition.dart';
import 'package:project/view/home/caffeine_view_modal.dart';
import 'package:project/view/home/hotlist_view_model.dart';
import 'package:project/view/setting/user_view_model.dart';
import 'package:project/widgets/icon_box.dart';
import 'package:project/widgets/line.dart';
import 'package:project/widgets/section/dialog_button_section.dart';
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
              _buildHotlistBoxList(context, provider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHotlistBoxList(
    BuildContext context,
    HotlistViewModel provider,
  ) {
    return Container(
      height: 166.sp,
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 12.sp),
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisSpacing: 10.sp,
        mainAxisSpacing: 10.sp,
        crossAxisCount: 2,
        childAspectRatio: 153 / 68,
        children: provider.items
            .map((item) => _buildHotlistBox(
                  context,
                  provider,
                  item,
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
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => const HotlistAddDialog(),
            ),
            icon: Icon(
              Icons.add,
              size: 18.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: Container(
              height: 22.sp,
              width: 28.sp,
              alignment: Alignment.center,
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

  Widget _buildHotlistBox(
    BuildContext context,
    HotlistViewModel provider,
    Hotlist hotlist,
  ) {
    final nameStyle =
        Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14.sp);
    final contextStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          fontSize: 12.sp,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );

    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => showDialog(
          context: context,
          builder: (context) => _buildSelectHotlistDialog(
            context,
            hotlist.name,
            hotlist.caffeine,
          ),
        ),
        child: Container(
          width: 153.sp,
          height: 68.sp,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hotlist.name,
                    style: nameStyle,
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog(
                        insetPadding: EdgeInsets.symmetric(vertical: 300.sp),
                        child:
                            _buildDeleteItemDialog(context, provider, hotlist),
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
                    padding:
                        EdgeInsets.symmetric(vertical: 4.sp, horizontal: 2.sp),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
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
        ),
      ),
    );
  }

  Widget _buildSelectHotlistDialog(
    BuildContext context,
    String name,
    double caffeine,
  ) {
    return Dialog(
      child: Container(
        height: 120.sp,
        width: 340.sp,
        padding: EdgeInsets.all(20.sp),
        child: Column(
          children: [
            SizedBox(
              width: 300.sp,
              child: Text(
                "${addObjectPostposition(name)} 추가하시겠습니까?",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 20.sp),
            SizedBox(
              width: 300.sp,
              child: DialogButtonSection(
                onPressConfirm: () {
                  Navigator.pop(context);
                  context.read<CaffeineViewModal>().setTodayCaffeine(caffeine);
                  // todo: record 추가
                },
                onPressCancel: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteItemDialog(
    BuildContext context,
    HotlistViewModel provider,
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
              "${addObjectPostposition(hotlist.name)} 삭제하시겠습니까?",
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
                    provider.deleteHotList(hotlist);
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

class HotlistAddDialog extends StatefulWidget {
  const HotlistAddDialog({super.key});

  @override
  State<StatefulWidget> createState() => HotlistAddDialogState();
}

class HotlistAddDialogState extends State<HotlistAddDialog> {
  String name = "";
  double caffeine = 0.0;
  String detail = "";

  @override
  Widget build(BuildContext context) {
    final int userId = context.read<UserViewModel>().item.length == 1
        ? context.read<UserViewModel>().item[0].id
        : 0;

    return Dialog(
      child: Container(
        width: 340.sp,
        height: 316.sp,
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: [
            Container(
              height: 20.sp,
              alignment: Alignment.centerLeft,
              child: Text(
                "즐겨찾기 추가",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 20.sp),
            TextField(
              onChanged: (value) => {name = value},
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "이름",
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.cancel_outlined),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) => {caffeine = double.parse(value)},
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "카페인 함유량",
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.cancel_outlined),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            TextField(
              onChanged: (value) => {detail = value},
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "설명",
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.cancel_outlined),
                ),
              ),
            ),
            SizedBox(height: 20.sp),
            Container(
              width: 300.sp,
              height: 40.sp,
              alignment: Alignment.centerRight,
              child: DialogButtonSection(
                onPressConfirm: () {
                  context
                      .read<HotlistViewModel>()
                      .createHotList(userId, name, detail, caffeine);
                  Navigator.pop(context);
                },
                onPressCancel: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
