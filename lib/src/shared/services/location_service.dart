import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final locationServiceProvider = Provider((ref) => LocationService());

class LocationService {
  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream();
  }
}
