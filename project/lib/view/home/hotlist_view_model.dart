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

  void deleteHotList(Hotlist hotlist) async {
    await _hotlistRepository.deleteHotlist(hotlist.id!);

    _items.remove(hotlist);
    notifyListeners();
  }

  void createHotList(
    String name,
    String detail,
    double caffeine,
  ) async {
    final Hotlist hotlist = Hotlist(
      name: name,
      detail: detail,
      caffeine: caffeine,
    );
    final Hotlist saved = await _hotlistRepository.insertHotlist(hotlist);

    _items.add(saved);
    notifyListeners();
  }
}
