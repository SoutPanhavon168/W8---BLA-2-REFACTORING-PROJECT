import 'package:blabla/model/ride/ride.dart';

abstract class RideRepository {
  Future<List<Ride>> getRides();
}
