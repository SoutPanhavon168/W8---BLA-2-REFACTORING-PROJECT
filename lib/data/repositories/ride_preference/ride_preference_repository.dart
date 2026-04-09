import '/model/ride/locations.dart';
import '/model/ride_pref/ride_pref.dart';

abstract class RidePreferenceRepository {
  RidePreference? get currentPreference;
  void setPreference(RidePreference preference);
  Future<List<RidePreference>> getHistory();
}
