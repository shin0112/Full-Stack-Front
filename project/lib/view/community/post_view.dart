import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/config/themes/theme.dart';
import 'package:project/data/model/post.dart';
import 'package:project/utils/get_size.dart';
import 'package:project/view/community/post_view_model.dart';
import 'package:project/widgets/icon_box.dart';
import 'package:project/widgets/line.dart';
import 'package:project/widgets/section/dialog_button_section.dart';
import 'package:provider/provider.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Consumer<PostViewModel>(
      builder: (context, provider, child) => Stack(
        children: [
          SizedBox(
            height: getHeight(620, size),
            child: Column(
              children: [
                _buildPostModeButtonSection(
                  context,
                  provider,
                ),
                const HorizontalLine(width: 360),
                SizedBox(
                  child: provider.items.isEmpty
                      ? const Center(child: Text("준비 중입니다."))
                      : ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: (provider.mode.mode == 0
                                  ? provider.items
                                  : provider.myPostList)
                              .map((item) => _buildPostBox(
                                    context,
                                    item,
                                  ))
                              .toList(),
                        ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10.sp,
            right: 18.sp,
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => const PostAddDialog()),
              child: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          ),
        ],
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

  Widget _buildPostBox(
    BuildContext context,
    Post post,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => _buildPostReadDialog(
            context,
            post,
          ),
        ),
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
                      post.title,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 16.sp),
                    ),
                    Text(
                      post.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostReadDialog(
    BuildContext context,
    Post post,
  ) {
    return Dialog.fullscreen(
      child: Container(
        padding: EdgeInsets.only(top: 20.sp, right: 20.sp, left: 20.sp),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 48.sp,
                width: 360.sp,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                child: Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 22.sp,
                      ),
                ),
              ),
              SizedBox(height: 10.sp),
              Container(
                height: 300.sp,
                width: 360.sp,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.onSurface),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  post.content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                      ),
                ),
              ),
              SizedBox(height: 10.sp),
              Container(
                width: 360.sp,
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "닫기",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 14.sp,
                        ),
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}

class PostAddDialog extends StatefulWidget {
  const PostAddDialog({super.key});

  @override
  State<StatefulWidget> createState() => PostAddDialogState();
}

class PostAddDialogState extends State<PostAddDialog> {
  String title = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Container(
        padding: EdgeInsets.only(top: 20.sp, right: 20.sp, left: 20.sp),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TextField(
                onChanged: (value) => {title = value},
                decoration: const InputDecoration(
                  labelText: "제목",
                ),
              ),
              SizedBox(height: 10.sp),
              TextField(
                maxLines: 30,
                onChanged: (value) => {content = value},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.sp),
              DialogButtonSection(
                onPressConfirm: () {
                  context.read<PostViewModel>().create(title, content);
                  Navigator.pop(context);
                },
                onPressCancel: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
