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
        height: 620.sp,
        padding: EdgeInsets.only(right: 16.sp, left: 16.sp, top: 20.sp),
        child: provider.items.isEmpty
            ? const Center(
                child: Text("준비 중입니다."),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children:
                    provider.items.map((item) => PostBox(post: item)).toList(),
              ),
      ),
    );
  }
}

class PostBox extends StatefulWidget {
  Post? post;

  PostBox({super.key, this.post});

  @override
  State<StatefulWidget> createState() => PostBoxState();
}

class PostBoxState extends State<PostBox> {
  PostBoxState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // todo: 터치 시 로직 작성
      onTap: () {},
      child: Container(
        width: 328.sp,
        height: 88.sp,
        padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 12.sp),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          )),
          borderRadius: BorderRadius.circular(6),
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        child: Row(
          children: [
            Container(
              width: 64.sp,
              height: 64.sp,
              color: Theme.of(context).colorScheme.secondaryContainer,
              alignment: Alignment.center,
              child: const IconBox(icon: Icons.local_cafe_outlined),
            ),
            SizedBox(width: 16.sp),
            SizedBox(
              width: 216.sp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post?.title ??
                        "dkssudgktpdddddddddddddddddddddddddddddddddddddddddddddddy",
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  Text(
                    widget.post?.context ??
                        "아에ㅣㅇ오우dkssudgktpdddddddddddddddddddddddddddddddddddddddddddddddy",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
