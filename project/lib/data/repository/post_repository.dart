import 'package:project/data/datasource/post_datasource.dart';
import 'package:project/data/model/post.dart';

class PostRepository {
  final PostDatasource _postDatasource = PostDatasource();

  PostRepository();

  Future<List<Post>> fetchData() async {
    return await _postDatasource.findAll();
  }

  Future<List<Post>> getMine() async {
    return await _postDatasource.findMine();
  }
}
