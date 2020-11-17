import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';

final locationServiceProvider =
    Provider<LocationService>((ref) => LocationService());

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

  Future<LocationData> getLocation() async {
    _checkLocationServiceAndPermission();
    return await _location.getLocation();
  }

  Stream<LocationData> getLocationStream() {
    _checkLocationServiceAndPermission();
    return _location.onLocationChanged;
  }
}
