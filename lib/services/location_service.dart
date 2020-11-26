import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';

/// Provides the LocationService class
final locationServiceProvider =
    Provider<LocationService>((ref) => LocationService());

/// Provides the location of the device
class LocationService {
  final _location = Location();

  void _checkLocationServiceAndPermission() {
    _location.serviceEnabled().then((isServiceEnabled) {
      if (!isServiceEnabled) {
        _location.requestService().then((isServiceEnabled) {
          if (!isServiceEnabled) {
            return;
          }
        });
      }
    });

    _location.hasPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.denied) {
        _location.requestPermission().then((permissionStatus) {
          if (permissionStatus != PermissionStatus.granted) {
            return;
          }
        });
      }
    });
  }

  /// Gets the current location of the device
  Future<LocationData> getLocation() async {
    _checkLocationServiceAndPermission();
    return await _location.getLocation();
  }

  /// Returns a stream of location information of the device
  Stream<LocationData> getLocationStream() {
    _checkLocationServiceAndPermission();
    return _location.onLocationChanged;
  }
}
