import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/model/ride/ride.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';

class RideSelectionViewModel {
  final RidePreferenceState1 state;
  final RideRepository repository;

  List<Ride> rides = [];

  RideSelectionViewModel(this.state, this.repository);

  Future<void> loadRides() async {
    final allRides = await repository.getAllRides();

    final pref = state.selected;
    if (pref == null) return;

    rides = allRides.where((ride) {
      return ride.departureLocation == pref.departure &&
          ride.arrivalLocation == pref.arrival &&
          ride.availableSeats >= pref.requestedSeats;
    }).toList();
  }
}
