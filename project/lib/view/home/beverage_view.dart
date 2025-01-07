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
  bool _isIceButton = true;

  void selectId(int id) {
    setState(() {
      _selectedId = id;
    });
  }

  void selectTemp(bool isIceButton) {
    setState(() {
      _isIceButton = isIceButton;
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
            _buildRightSection(context),
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

  Widget _buildRightSection(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: _buildButtonSection(context),
        )
      ],
    );
  }

  Widget _buildButtonSection(BuildContext context) {
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
            style: _isIceButton ? selectedButtonStyle : unselectedButtonStyle,
            onPressed: () => selectTemp(true),
            child: Text(
              "ICE",
              style: _isIceButton ? selectedTextStyle : unselectedTextStyle,
            ),
          ),
          OutlinedButton(
            style: _isIceButton ? unselectedButtonStyle : selectedButtonStyle,
            onPressed: () => selectTemp(false),
            child: Text(
              "HOT",
              style: _isIceButton ? unselectedTextStyle : selectedTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
