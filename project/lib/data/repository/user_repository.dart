import 'package:project/data/datasource/user_datasource.dart';
import 'package:project/data/model/user.dart';

class UserRepository {
  final UserDatasource _userDatasource = UserDatasource();

  UserRepository();

  Future<User> fetchData() async {
    return await _userDatasource.getUser();
  }
}
