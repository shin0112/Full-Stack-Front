import 'package:project/data/datasource/user_datasource.dart';
import 'package:project/data/model/user.dart';

class UserRepository {
  final UserDatasource _userDatasource = UserDatasource();

  UserRepository();

  Future<User> getUser() async {
    return await _userDatasource.getUser();
  }

  Future<User> updateUser(
    String name,
    int age,
    double height,
    double weight,
  ) async {
    return await _userDatasource.updateUser(name, age, height, weight);
  }
}
