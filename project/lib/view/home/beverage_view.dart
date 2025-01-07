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
    return Container(
      width: 80.sp,
      height: 670.sp,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(color: Theme.of(context).colorScheme.outline))),
      child: Column(
        children: [
          _buildTextBox(context, provider, "전체", 0),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: provider.brandList.entries.map((entry) {
                final String category = entry.key;
                final List<Brand> items = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildTextBox(context, provider, category, 0, 2),
                    ...items.map(
                      (item) => _buildTextBox(
                        context,
                        provider,
                        item.name,
                        item.id,
                        item.id == provider.selectedId ? 1 : 0,
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

  Widget _buildTextBox(
      BuildContext context, BeverageViewModel provider, String text, int id,
      [int type = 0]) {
    TextStyle defaultTextStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp);

    switch (type) {
      // default
      case 0:
        return GestureDetector(
          onTap: () => provider.selectId(id),
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

  Widget _buildRightSection(
      BuildContext context, BeverageViewModel provider, Size size) {
    TextStyle selectedTextStyle =
        Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onPrimary,
            );
    TextStyle unselectedTextStyle =
        Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: 14.sp,
              color: MaterialTheme.coffee.seed,
            );
    ButtonStyle selectedButtonStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return MaterialTheme.coffee.seed.withOpacity(0.8);
          }
          return MaterialTheme.coffee.seed; // Use the component's default.
        },
      ),
    );
    ButtonStyle unselectedButtonStyle = const ButtonStyle();

    return SizedBox(
      width: 280.sp,
      child: Row(
        children: [
          OutlinedButton(
            style: provider.isIceButton
                ? selectedButtonStyle
                : unselectedButtonStyle,
            onPressed: () => provider.selectTemp(true),
            child: Text(
              "ICE",
              style: provider.isIceButton
                  ? selectedTextStyle
                  : unselectedTextStyle,
            ),
          ),
          OutlinedButton(
            style: provider.isIceButton
                ? unselectedButtonStyle
                : selectedButtonStyle,
            onPressed: () => provider.selectTemp(false),
            child: Text(
              "HOT",
              style: provider.isIceButton
                  ? unselectedTextStyle
                  : selectedTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
