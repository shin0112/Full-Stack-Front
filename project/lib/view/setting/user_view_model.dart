import 'package:flutter/material.dart';
import 'package:project/data/model/user.dart';
import 'package:project/data/repository/user_repository.dart';

class UserViewModel with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  User get user => _user;
  User _user = User();

  int? get userId => _userId;
  int? _userId;

  UserViewModel() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    _user = await _userRepository.fetchData();
    _userId = _user.id;

    notifyListeners();
  }

  void updateData(
    String name,
    int age,
    double height,
    double weight,
  ) {
    _user.name = name;
    _user.age = age;
    _user.height = height;
    _user.weight = weight;
    notifyListeners();
  }
}
