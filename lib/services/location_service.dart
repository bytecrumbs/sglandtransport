import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';

@lazySingleton
class LocationService {
  final Location _location = Location();
  UserLocation _userLocation = UserLocation(
    latitude: null,
    longitude: null,
    permissionGranted: false,
  );

  UserLocation get userLocation => _userLocation;

  LocationService() {
    _location.requestPermission().then((ps) {
      if (ps == PermissionStatus.granted) {
        _location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _userLocation = UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
              permissionGranted: true,
            );
          }
        });
      }
    });
  }
}
