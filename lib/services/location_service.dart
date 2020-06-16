import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';

@lazySingleton
class LocationService {
  final Location _location = Location();
  // Continuously emit location updates
  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    _location.requestPermission().then((ps) {
      if (ps == PermissionStatus.granted) {
        _location.onLocationChanged.listen((locationData) {
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
