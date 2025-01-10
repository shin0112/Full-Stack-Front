import 'package:project/config/database/hive_database.dart';
import 'package:project/data/model/user.dart';

class UserDatasource {
  UserDatasource();

  Future<void> saveUser(User user) async {
    final userBox = await HiveDatabase().userBox;
    await userBox.add(user);
  }

  Future<User> getUser() async {
    final userBox = await HiveDatabase().userBox;
    return userBox.getAt(0)!;
  }
}
