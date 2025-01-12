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
            _buildPostModeButtonSection(
              context,
              provider,
            ),
            const HorizontalLine(width: 360),
            SizedBox(
              height: 56.sp * provider.items.length,
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

  Widget _buildPostModeButtonSection(
    BuildContext context,
    PostViewModel provider,
  ) {
    final TextStyle buttonTextStyle =
        Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14.sp,
              color: MaterialTheme.coffee.seed,
            );
    final TextStyle selectedButtonTextStyle =
        Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onPrimary,
            );
    final ButtonStyle buttonStyle = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        side: BorderSide(
          color: MaterialTheme.coffee.seed,
          width: 1,
        ),
      ),
    );
    final ButtonStyle selectedButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      backgroundColor: MaterialTheme.coffee.seed,
    );

    return Container(
      height: 56.sp,
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
      child: Row(
        children: [
          TextButton(
            style: provider.mode.mode == 0 ? selectedButtonStyle : buttonStyle,
            onPressed: () {
              provider.changeMode(0);
            },
            child: Text("전체",
                style: provider.mode.mode == 0
                    ? selectedButtonTextStyle
                    : buttonTextStyle),
          ),
          SizedBox(width: 10.sp),
          TextButton(
            style: provider.mode.mode == 1 ? selectedButtonStyle : buttonStyle,
            onPressed: () {
              provider.changeMode(1);
            },
            child: Text("MY",
                style: provider.mode.mode == 1
                    ? selectedButtonTextStyle
                    : buttonTextStyle),
          ),
        ],
      ),
    );
  }
}

class PostBox extends StatefulWidget {
  final Post post;

  const PostBox({super.key, required this.post});

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
                    widget.post.content,
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
