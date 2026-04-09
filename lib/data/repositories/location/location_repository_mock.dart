import '/data/dummy_data.dart';
import '/data/repositories/location/location_repository.dart';
import '/model/ride/locations.dart';

class LocationRepositoryMock implements LocationRepository {
  List<Location> locations = [];

  @override
  Future<List<Location>> getAllLocations() async {
    locations = fakeLocations;
    if (locations.isEmpty) {
      throw Exception("Location is Empty");
    }
    return locations;
  }

  @override
  Future<Location> getLocationByName(String name) async {
    List<Location> locations = await getAllLocations();
    return locations.firstWhere((location) {
      return location.name == name;
    });
  }
}
