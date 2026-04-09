import 'package:blabla/data/dummy_data.dart';
import 'package:blabla/data/repositories/location/location_repository.dart';
import 'package:blabla/model/ride/locations.dart';

class LocationRepositoryMock implements LocationRepository {
  @override
  Future<List<Location>> getLocations() async {
    return fakeLocations;
  }
}
