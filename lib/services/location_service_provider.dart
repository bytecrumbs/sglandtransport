import 'dart:async';

import 'package:location/location.dart';
import 'package:lta_datamall_flutter/models/user_location.dart';

class LocationServiceProvider {
  // Keep track of current Location
  UserLocation _currentLocation;
  Location location = Location();
  // Continuously emit location updates
  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationServiceProvider() {
    location.requestPermission().then((ps) {
      if (ps == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(
              UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude,
              ),
            );
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } catch (e) {
      print('Could not get the location: $e');
    }

    return _currentLocation;
  }
}
