import 'package:flutter/material.dart';
import 'package:project/data/model/post.dart';
import 'package:project/data/repository/post_repository.dart';

class PostViewModel with ChangeNotifier {
  final PostRepository _postRepository = PostRepository();

  List<Post> get items => _items;
  List<Post> _items = [];

  PostViewModel() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    _items = await _postRepository.fetchData();
    notifyListeners();
  }
}
