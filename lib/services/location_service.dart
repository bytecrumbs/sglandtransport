import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

@lazySingleton
class LocationService {
  final Location _location = Location();

  Stream<LocationData> get onLocationChanged => _location.onLocationChanged;

  Future<void> enableLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}
