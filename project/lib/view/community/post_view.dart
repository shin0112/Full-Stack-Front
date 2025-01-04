import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/data/model/post.dart';
import 'package:project/view/community/post_view_model.dart';
import 'package:project/widgets/icon_box.dart';
import 'package:project/widgets/line.dart';
import 'package:provider/provider.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(
      builder: (context, provider, child) => SizedBox(
        height: 620.sp,
        // todo: 글쓰기 버튼 추가
        child: Column(
          children: [
            const PostButtonSection(),
            const HorizontalLine(width: 360),
            SizedBox(
              height: 563.sp,
              child: provider.items.isEmpty
                  ? const Center(child: Text("준비 중입니다."))
                  : ListView(
                      scrollDirection: Axis.vertical,
                      children: provider.items
                          .map((item) => PostBox(post: item))
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostMode {
  const PostMode(this.mode, this.title);
  final int mode;
  final String title;
}

class PostButtonSection extends StatefulWidget {
  const PostButtonSection({super.key});

  @override
  State<StatefulWidget> createState() => PostButtonSectionState();
}

class PostButtonSectionState extends State<PostButtonSection> {
  static const List<PostMode> postModeList = <PostMode>[
    PostMode(0, '전체'),
    PostMode(1, '인기'),
    PostMode(2, 'MY'),
  ];

  @override
  Widget build(BuildContext context) {
    final TextStyle buttonTextStyle =
        Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14.sp,
              color: MaterialTheme.coffee.seed,
            );
    final ButtonStyle buttonStyle = TextButton.styleFrom(
        shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      side: BorderSide(
        color: MaterialTheme.coffee.seed,
        width: 1,
      ),
    ));

    return Container(
      height: 56.sp,
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
      child: Row(
        // todo: mode 변경 로직 및 버튼 로직 작성
        children: [
          TextButton(
            style: buttonStyle,
            onPressed: () {},
            child: Text("전체", style: buttonTextStyle),
          ),
          SizedBox(width: 10.sp),
          TextButton(
            style: buttonStyle,
            onPressed: () {},
            child: Text("인기", style: buttonTextStyle),
          ),
          SizedBox(width: 10.sp),
          TextButton(
            style: buttonStyle,
            onPressed: () {},
            child: Text("MY", style: buttonTextStyle),
          ),
        ],
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
      // todo: 터치 시 로직 작성, 좋아요 추가
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
          color: Theme.of(context).colorScheme.surfaceContainerLowest,
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
                    widget.post.title,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 16.sp),
                  ),
                  Text(
                    widget.post.context,
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
