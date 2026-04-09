import '/model/ride/locations.dart';
import '/model/ride/ride.dart';

abstract class RideRepository {
  Future<List<Ride>> getAllRides();
  Future<Location> getDepartureLocation(Location location);
  Future<Location> getArriveLocation(Location location);
}