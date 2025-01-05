import 'package:flutter/material.dart';
import 'package:project/data/model/hotlist.dart';
import 'package:project/data/repository/hotlist_repository.dart';

class HotlistViewModel with ChangeNotifier {
  final HotlistRepository _hotlistRepository = HotlistRepository();

  List<Hotlist> get items => _items;
  List<Hotlist> _items = [];

  HotlistViewModel() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    _items = await _hotlistRepository.getItems();
    notifyListeners();
  }
}
