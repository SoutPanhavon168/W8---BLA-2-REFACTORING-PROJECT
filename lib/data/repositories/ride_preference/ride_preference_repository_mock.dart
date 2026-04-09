import '/data/dummy_data.dart';
import '/model/ride/locations.dart';
import '/model/ride_pref/ride_pref.dart';

class RidePreferenceRepositoryMock implements RidePreference {
  RidePreference? _currentPreference;

  RidePreference? get currentPreference => _currentPreference;

  @override
  void setPreference(RidePreference preference) {
    _currentPreference = preference;
  }

    @override
  Location get arrival => _currentPreference!.arrival;

  @override
  Location get departure => _currentPreference!.departure;

  @override
  DateTime get departureDate => _currentPreference!.departureDate;

  @override
  int get requestedSeats => _currentPreference!.requestedSeats;

  @override
  Future<List<RidePreference>> getHistory() async{
    List<RidePreference> ridePref =  fakeRidePrefs;
    return ridePref;
  }


}