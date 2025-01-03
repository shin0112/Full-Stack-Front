import 'package:flutter/material.dart';
import 'package:project/view/community/post_view.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [const PostView()],
    );
  }
}
