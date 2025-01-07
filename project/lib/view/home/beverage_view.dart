import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/data/model/brand.dart';
import 'package:project/view/home/beverage_view_model.dart';
import 'package:provider/provider.dart';

class BeverageView extends StatefulWidget {
  const BeverageView({super.key});

  @override
  State<StatefulWidget> createState() => BeverageViewState();
}

class BeverageViewState extends State<BeverageView> {
  int _selectedId = 0;

  void selectId(int id) {
    setState(() {
      _selectedId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BeverageViewModel>(
      builder: (context, provider, child) => SizedBox(
        height: 670.sp,
        child: Row(
          children: [
            _buildLeftSection(context, provider.brandList),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSection(
      BuildContext context, Map<String, List<Brand>> brandList) {
    return Container(
      width: 80.sp,
      height: 670.sp,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(color: Theme.of(context).colorScheme.outline))),
      child: Column(
        children: [
          _buildTextBox("전체", 0),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: brandList.entries.map((entry) {
                final String category = entry.key;
                final List<Brand> items = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTextBox(category, 0, 2),
                    ...items.map(
                      (item) => _buildTextBox(
                        item.name,
                        item.id,
                        item.id == _selectedId ? 1 : 0,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextBox(String text, int id, [int type = 0]) {
    TextStyle defaultTextStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp);

    switch (type) {
      // default
      case 0:
        return GestureDetector(
          onTap: () => selectId(id),
          child: Container(
            height: 36.sp,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 8.sp),
            child: Text(text, style: defaultTextStyle),
          ),
        );
      // selected
      case 1:
        return Container(
          height: 36.sp,
          alignment: Alignment.center,
          color: Theme.of(context).colorScheme.secondaryContainer,
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          child: Text(text, style: defaultTextStyle),
        );
      // category
      case 2:
        return Container(
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
            text,
            style: defaultTextStyle.copyWith(
                color: Theme.of(context).colorScheme.onSecondary),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
