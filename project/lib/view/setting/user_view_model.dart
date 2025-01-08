import 'package:flutter/material.dart';
import 'package:project/data/model/user.dart';
import 'package:project/data/repository/user_repository.dart';

class UserViewModel with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  List<User> get item => _item;
  List<User> _item = [];

  UserViewModel() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    _item = await _userRepository.fetchData();
    notifyListeners();
  }

  void updateData(
    String name,
    int age,
    double height,
    double weight,
  ) {
    _item[0].name = name;
    _item[0].age = age;
    _item[0].height = height;
    _item[0].weight = weight;
    notifyListeners();
  }
}
