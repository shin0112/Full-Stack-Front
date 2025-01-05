import 'package:flutter/material.dart';
import 'package:project/data/model/user.dart';
import 'package:project/data/repository/user_repository.dart';
import 'package:provider/provider.dart';

class UserViewModel with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  User get item => _item;
  User _item = User(
      id: 0,
      age: 20,
      name: "유저",
      username: "",
      password: "",
      height: 170,
      weight: 60);

  UserViewModel() {
    _fetchData();
  }

  Future<User> _fetchData() async {
    _item = await _userRepository
        .fetchData()
        .onError(throw ProviderNotFoundException);
  }
}
