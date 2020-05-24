import 'dart:async';

import 'package:location/location.dart';
import 'package:lta_datamall_flutter/models/user_location.dart';

class LocationProvider {
  Location location = Location();
  // Continuously emit location updates
  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationProvider() {
    location.requestPermission().then((ps) {
      if (ps == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(
              UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude,
                permissionGranted: true,
              ),
            );
          }
        });
      } else {
        _locationController.add(
          UserLocation(
            latitude: null,
            longitude: null,
            permissionGranted: false,
          ),
        );
      }
    });
  }
}
