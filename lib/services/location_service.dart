import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';

@lazySingleton
class LocationService {
  final Location _location = Location();

  Future<UserLocation> getUserLocation() async {
    var userLocation = UserLocation(
      latitude: 0,
      longitude: 0,
      permissionGranted: false,
    );

    await _location.changeSettings(accuracy: LocationAccuracy.low);

    var _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return userLocation;
      }
    }

    var locationData = await _location.getLocation();
    userLocation = UserLocation(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
      permissionGranted: true,
    );

    return userLocation;
  }
}
