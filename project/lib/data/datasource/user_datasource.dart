import 'package:project/config/database/hive_database.dart';
import 'package:project/data/model/user.dart';

class UserDatasource {
  UserDatasource();

  Future<User> saveUser(
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
    return userBox.getAt(0)!;
  }
}
