import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:project/config/database/hive_database.dart';
import 'package:project/data/model/user.dart';

class UserDatasource {
  final String baseUrl = dotenv.env['BASE_URL']!;
  UserDatasource();

  Future<User> updateUser(
    String name,
    int age,
    double height,
    double weight,
  ) async {
    final userBox = await HiveDatabase().userBox;
    final user = userBox.getAt(0)!;

    user.name = name;
    user.age = age;
    user.height = height;
    user.weight = weight;

    user.save();
    return userBox.getAt(0)!;
  }

  Future<User> getUser() async {
    final userBox = await HiveDatabase().userBox;
    final user = userBox.getAt(0)!;

    log("getUser 호출: 사용자 ID=${user.id}");

    if (user.id == 0) {
      try {
        final uri = Uri.parse("$baseUrl/home");
        log("home API 호출 시작: URL=$uri");

        final response =
            await http.get(uri).timeout(const Duration(seconds: 5));
        log("API 응답 상태 코드: ${response.statusCode}");

        if (response.statusCode == 200) {
          final Map<String, dynamic> json = jsonDecode(response.body);
          user.id = json['data']['id'] as int;

          log("API 응답 처리 완료: 사용자 ID=${user.id}");

          await userBox.putAt(0, user);
          log("사용자 데이터 저장 완료");
        } else {
          log("API 호출 실패: 상태 코드 ${response.statusCode}");
          throw Exception("Failed to fetch user data from API.");
        }

        log("home API 종료");
      } on TimeoutException {
        log("API 호출이 타임아웃되었습니다.");
        throw Exception("Request to $baseUrl timed out.");
      } catch (e) {
        log("API 호출 중 오류 발생: $e");
        rethrow;
      }
    } else {
      log("사용자 ID가 0이 아니므로 API 호출 안 함. 현재 ID: ${user.id}");
    }

    return userBox.getAt(0)!;
  }
}
