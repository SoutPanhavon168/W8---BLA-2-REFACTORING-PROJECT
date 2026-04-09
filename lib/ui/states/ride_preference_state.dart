import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';

class RidePreferenceState1 extends ChangeNotifier {
  final RidePreferenceRepository repo;

  static const int maxSeatsAllowed = 8;

  RidePreference? _selected;
  List<RidePreference> _items = [];

  RidePreferenceState1(this.repo) {
    _load();
  }

  RidePreference? get selected => _selected;
  List<RidePreference> get items => _items;

  Future<void> _load() async {
    _items = await repo.getHistory();

    if (_items.isNotEmpty) {
      _selected = _items.last;
    }

    notifyListeners();
  }

  Future<void> fetchItems() async {
    _items = await repo.getHistory();
    notifyListeners();
  }

  void setSelected(RidePreference pref) {
    if (_selected == pref) return;

    _selected = pref;
    _items.add(pref);
    notifyListeners();
  }
}
