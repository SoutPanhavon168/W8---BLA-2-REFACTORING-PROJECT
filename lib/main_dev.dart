import 'package:blabla/data/repositories/location/location_repository.dart';
import 'package:blabla/data/repositories/location/location_repository_mock.dart';
import 'package:blabla/data/repositories/ride/ride_repository.dart';
import 'package:blabla/data/repositories/ride/ride_repository_mock.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository.dart';
import 'package:blabla/data/repositories/ride_preference/ride_preference_repository_mock.dart';
import 'package:blabla/ui/states/ride_preference_state.dart';
import 'package:flutter/material.dart';
import 'main_common.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<LocationRepository>(create: (_) => LocationRepositoryMock()),
        Provider<RideRepository>(create: (_) => RideRepositoryMock()),
        Provider<RidePreferenceRepository>(
          create: (_) => MockRidePreferenceRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              RidePreferenceState1(context.read<RidePreferenceRepository>()),
        ),
      ],
      child: const BlaBlaApp(),
    ),
  );
}
