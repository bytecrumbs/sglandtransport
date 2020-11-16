import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';

final locationServiceProvider =
    Provider<LocationService>((ref) => LocationService());

class LocationService {
  var location = Location();

  void _checkLocationServiceAndPermission() {
    location.serviceEnabled().then((isServiceEnabled) {
      if (!isServiceEnabled) {
        location.requestService().then((isServiceEnabled) {
          if (!isServiceEnabled) {
            return;
          }
        });
      }
    });

    location.hasPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.denied) {
        location.requestPermission().then((permissionStatus) {
          if (permissionStatus != PermissionStatus.granted) {
            return;
          }
        });
      }
    });
  }

  Stream<LocationData> getLocationStream() {
    _checkLocationServiceAndPermission();
    return location.onLocationChanged;
  }
}
