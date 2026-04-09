import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';
import 'package:flutter/material.dart';

class RidePreferenceState extends ChangeNotifier {
  final RidePreferenceRepository repository;

  static const int maxAllowedSeats = 8;

  RidePreference? _current;
  List<RidePreference> _history = [];

  RidePreferenceState(this.repository) {
    _init();
  }

  Future<void> _init() async {
    await loadHistory();
    if (_current == null && _history.isNotEmpty) {
      _current = _history.last;
      notifyListeners();
    }
  }

  RidePreference? get current => _current;
  List<RidePreference> get history => _history;

  Future<void> loadHistory() async {
    _history = await repository.getHistory();
    notifyListeners();
  }

  void selectPreference(RidePreference newPref) {
    if (_current != newPref) {
      _current = newPref;
      _history.add(newPref);
      notifyListeners();
    }
  }
}
