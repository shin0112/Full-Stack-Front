import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/data/model/brand.dart';
import 'package:project/view/home/beverage_view_model.dart';
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
                  style: defaultTextStyle.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
              ...items.map(
                (item) => provider.selectedId == item.id
                    ? _buildSelectedTextBox(
                        context, defaultTextStyle, item.name)
                    : GestureDetector(
                        onTap: () => provider.selectId(item.id),
                        child: _buildUnselectedTextBox(
                            context, defaultTextStyle, item.name)),
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
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
          ),
          ListView()
        ],
      ),
    );
  }
}
