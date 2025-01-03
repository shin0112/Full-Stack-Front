import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/data/model/post.dart';
import 'package:project/view/community/post_view_model.dart';
import 'package:project/widgets/icon_box.dart';
import 'package:provider/provider.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(
      builder: (context, provider, child) => Container(
          padding: EdgeInsets.only(right: 16.sp, left: 16.sp, top: 20.sp),
          child: const Center(child: Text("준비 중입니다."))),
    );
  }
}
