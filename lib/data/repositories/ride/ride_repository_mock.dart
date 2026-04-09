import '/data/dummy_data.dart';
import '/data/repositories/ride/ride_repository.dart';
import '/model/ride/locations.dart';
import '/model/ride/ride.dart';

class RideRepositoryMock implements RideRepository {
  List<Ride> rides = [];

  @override
  Future<List<Ride>> getAllRides() async {
    rides = fakeRides;
    return rides;
  }

  @override
  Future<Location> getDepartureLocation(Location location) async {
    List<Ride> rides = await getAllRides();

    for (var ride in rides) {
      if (ride.departureLocation.name == location.name) {
        return ride.departureLocation;
      }
    }

    throw Exception('No ride found for location: ${location.name}');
  }

  @override
  Future<Location> getArriveLocation(Location location) async {
    List<Ride> rides = await getAllRides();

    for (var ride in rides) {
      if (ride.arrivalLocation.name == location.name) {
        return ride.arrivalLocation;
      }
    }

    throw Exception('No ride found for location: ${location.name}');
  }
}
