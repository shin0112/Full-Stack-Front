import 'package:flutter/services.dart';
import 'package:project/data/model/user.dart';

class UserRepository {
  UserRepository();

  Future<User> fetchData() async {
    String jsonString = await rootBundle.loadString('assets/dummy/user.json');
    return parseUserFromJson(jsonString);
  }
}
