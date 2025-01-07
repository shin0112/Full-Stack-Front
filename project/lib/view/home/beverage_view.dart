import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BeverageView extends StatefulWidget {
  const BeverageView({super.key});

  @override
  State<StatefulWidget> createState() => BeverageViewState();
}

class BeverageViewState extends State<BeverageView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 670.sp,
      child: Row(
        children: [_buildLeftList(context)],
      ),
    );
  }

  Widget _buildLeftList(BuildContext context) {
    return Column(
      children: [Text("전체")],
    );
  }
}
