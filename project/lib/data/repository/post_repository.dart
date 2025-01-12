import 'package:project/data/datasource/post_datasource.dart';
import 'package:project/data/model/post.dart';

class PostRepository {
  PostDatasource _postDatasource = PostDatasource();

  PostRepository();

  // todo: 실제 데이터 연결하기
  Future<List<Post>> fetchData() async {
    return await _postDatasource.findAll();
  }
}
