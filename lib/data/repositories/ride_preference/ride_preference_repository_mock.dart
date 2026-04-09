import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/model/ride_pref/ride_pref.dart';

class MockRidePreferenceRepository implements RidePreferenceRepository {
  @override
  Future<List<RidePreference>> getHistory() async {
    return fakeRidePrefs;
  }
}
