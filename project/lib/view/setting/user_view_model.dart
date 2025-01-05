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
}
