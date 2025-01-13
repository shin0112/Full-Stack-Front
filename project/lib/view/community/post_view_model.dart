import 'package:flutter/material.dart';
import 'package:project/data/model/post.dart';
import 'package:project/data/repository/post_repository.dart';

class PostMode {
  const PostMode(this.mode, this.title);
  final int mode;
  final String title;
}

class PostViewModel with ChangeNotifier {
  final PostRepository _postRepository = PostRepository();

  List<Post> get items => _items;
  List<Post> _items = [];

  List<Post> _myPostList = [];
  List<Post> get myPostList {
    _getMyPostList();
    return _myPostList;
  }

  PostMode get mode => _mode;
  PostMode _mode = postModeList[0];

  static const List<PostMode> postModeList = <PostMode>[
    PostMode(0, '전체'),
    PostMode(1, 'MY'),
  ];

  PostViewModel() {
    _fetchData();
    _getMyPostList();
  }

  Future<void> _fetchData() async {
    _items = await _postRepository.fetchData();
    notifyListeners();
  }

  Future<void> _getMyPostList() async {
    if (_myPostList.isEmpty) {
      _myPostList = await _postRepository.getMine();
      notifyListeners();
    }
  }

  Future<void> create(String title, String content) async {
    Post post = await _postRepository.create(title, content);
    items.add(post);
    myPostList.add(post);

    notifyListeners();
  }

  void changeMode(int mode) {
    _mode = postModeList[mode];
    notifyListeners();
  }
}
