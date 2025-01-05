import 'package:flutter/services.dart';
import 'package:project/data/model/post.dart';

class PostRepository {
  PostRepository();

  // todo: 실제 데이터 연결하기
  Future<List<Post>> fetchData() async {
    final String jsonString =
        await rootBundle.loadString('assets/dummy/post.json');
    return parsePostFromJson(jsonString);
  }
}
