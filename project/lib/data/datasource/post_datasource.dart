import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project/config/database/hive_database.dart';
import 'package:project/data/model/post.dart';

class PostDatasource {
  final String baseUrl = dotenv.env['BASE_URL']!;

  PostDatasource();

  Future<List<Post>> findAll() async {
    var userBox = await HiveDatabase().userBox;
    var userId = userBox.getAt(0)!.id;

    List<Post> postList = [];

    try {
      final uri = Uri.parse("$baseUrl/posts/users/$userId");
      final response = await http.get(uri).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        log("디코딩: $responseBody");

        final Map<String, dynamic> json = jsonDecode(responseBody);
        log("서버 응답: $json");

        try {
          postList = await parsePostFromJson(json['data']);
          log("파싱 데이터: $postList");
        } catch (e) {
          log("게시물 데이터 파싱 중 오류 발생: ${e.toString()}");
          rethrow;
        }
      } else {
        log("호출 실패: 상태 코드 ${response.statusCode}, 응답 내용: ${response.body}");
      }
    } catch (e) {
      log("findAll 오류 발생: ${e.toString()}");
      rethrow;
    }

    return postList;
  }

  Future<List<Post>> findMine() async {
    var userBox = await HiveDatabase().userBox;
    var userId = userBox.getAt(0)!.id;

    List<Post> postList = [];

    try {
      final uri = Uri.parse("$baseUrl/posts/mine/$userId");
      final response = await http.get(uri).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final String responseBody = utf8.decode(response.bodyBytes);
        log("디코딩: $responseBody");

        final Map<String, dynamic> json = jsonDecode(responseBody);
        log("서버 응답: $json");

        try {
          postList = await parsePostFromJson(json['data']);
          log("파싱 데이터: $postList");
        } catch (e) {
          log("게시물 데이터 파싱 중 오류 발생: ${e.toString()}");
          rethrow;
        }
      } else {
        log("호출 실패: 상태 코드 ${response.statusCode}, 응답 내용: ${response.body}");
      }
    } catch (e) {
      log("findAll 오류 발생: ${e.toString()}");
      rethrow;
    }

    return postList;
  }

  Future<void> create(String title, String content) async {
    var userBox = await HiveDatabase().userBox;
    var userId = userBox.getAt(0)!.id;

    try {
      final url = Uri.parse("$baseUrl/posts");
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'userId': userId,
              'title': title,
              'context': content,
            }),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        log("게시물 생성 성공");
      } else {
        log("게시물 생성 실패: 상태 코드 ${response.statusCode}");
      }
    } catch (e) {
      log("게시물 생성 중 오류 발생: $e");
      rethrow;
    }
  }
}
