import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/data/model/beverage.dart';
import 'package:project/data/model/brand.dart';
import 'package:project/utils/add_object_postposition.dart';
import 'package:project/view/calendar/calendar_view_model.dart';
import 'package:project/view/home/beverage_view_model.dart';
import 'package:project/view/home/caffeine_view_modal.dart';
import 'package:project/view/setting/user_view_model.dart';
import 'package:project/widgets/caffeine_box.dart';
import 'package:project/widgets/section/dialog_button_section.dart';
import 'package:provider/provider.dart';

class BeverageView extends StatelessWidget {
  const BeverageView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<BeverageViewModel>(
      builder: (context, provider, child) => SizedBox(
        height: 670.sp,
        child: Row(
          children: [
            _buildLeftSection(context, provider, size),
            _buildRightSection(context, provider, size),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSection(
    BuildContext context,
    BeverageViewModel provider,
    Size size,
  ) {
    TextStyle defaultTextStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp);
    return Container(
      width: size.width * 0.22,
      height: 670.sp,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(color: Theme.of(context).colorScheme.outline))),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: provider.brandList.entries.map((entry) {
          final String category = entry.key;
          final List<Brand> items = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 36.sp,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                decoration: BoxDecoration(
                  color: MaterialTheme.coffee.seed,
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              ...items.map(
                (item) => provider.selectedId == item.id
                    ? _buildSelectedTextBox(
                        context, defaultTextStyle, item.name)
                    : Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => provider.selectBrand(item.id, item.name),
                          child: _buildUnselectedTextBox(
                              context, defaultTextStyle, item.name),
                        ),
                      ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSelectedTextBox(
      BuildContext context, TextStyle textStyle, String name) {
    return Container(
      height: 36.sp,
      alignment: Alignment.center,
      color: Theme.of(context).colorScheme.secondaryContainer,
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: Text(name, style: textStyle),
    );
  }

  Widget _buildUnselectedTextBox(
      BuildContext context, TextStyle textStyle, String name) {
    return Container(
        height: 36.sp,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8.sp),
        child: Text(name, style: textStyle));
  }

  Widget _buildRightSection(
    BuildContext context,
    BeverageViewModel provider,
    Size size,
  ) {
    return SizedBox(
      width: size.width * 0.78,
      height: 670.sp,
      child: Column(
        children: [
          Container(
            height: 36.sp,
            width: size.width * 0.78,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            decoration: BoxDecoration(color: MaterialTheme.coffee.seed),
            child: Text(
              "음료 리스트",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
          Expanded(
            child: ListView(
              children: provider.beverageList.map((item) {
                if (provider.selectedId == item.brandId) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          insetPadding: EdgeInsets.symmetric(vertical: 300.sp),
                          child: _buildSelectedItemModal(
                            context,
                            provider.selectedBrand,
                            item,
                          ),
                        ),
                      ),
                      child: Container(
                        height: 44.sp,
                        width: size.width * 0.78,
                        padding: EdgeInsets.all(10.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 14.sp),
                            ),
                            CaffeineBox(caffeine: item.caffeine),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedItemModal(
    BuildContext context,
    String selectedBrand,
    Beverage item,
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
              "$selectedBrand ${addObjectPostposition(item.name)} 추가하시겠습니까?",
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
                Navigator.pop(context);
                context
                    .read<CaffeineViewModal>()
                    .setTodayCaffeine(item.caffeine);
                context.read<CalendarViewModel>().saveRecordFromBeverage(
                      item,
                      context.read<UserViewModel>().userId,
                    );
              },
              onPressCancel: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
