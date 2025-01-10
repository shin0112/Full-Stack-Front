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
    _items = await _hotlistRepository.findAll();
    notifyListeners();
  }

  void deleteHotList(Hotlist hotlist) {
    _items.remove(hotlist);
    notifyListeners();
  }

  void createHotList(
    String name,
    String detail,
    double caffeine,
  ) {
    items.add(Hotlist(
      id: _items.last.id + 1,
      name: name,
      detail: detail,
      caffeine: caffeine,
    ));
    notifyListeners();
  }
}
