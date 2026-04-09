import 'package:blabla/model/ride/locations.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocations();
}
