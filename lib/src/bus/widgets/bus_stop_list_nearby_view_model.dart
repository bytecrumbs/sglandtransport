import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../bus_database_service.dart';
import '../bus_repository.dart';

final busStopListNearbyViewModelProvider =
    Provider((ref) => BusStopListNearbyViewModel(ref.read));

class BusStopListNearbyViewModel {
  BusStopListNearbyViewModel(this.read);

  final Reader read;

  Stream<List<BusStopValueModel>> streamBusStops() async* {
    final busDbService = read(busDatabaseServiceProvider);

    // fetch all bus stops from the database and then filter based on the cached
    // result. This is more efficient than querying the local database with a filter
    // every time the location changes, I think... :-)
    final allBusStops = await busDbService.getBusStops();

    // this is needed so that the location is fetched again when the location of
    // the device has not changed since last time it was called. this is also
    // required as it might take a while until the next precise location
    // from below stream is being yielded
    final currentLocation = await Geolocator.getLastKnownPosition();
    yield busDbService.filterNearbyBusStops(
      currentLatitude: currentLocation?.latitude ?? 0,
      currentLongitude: currentLocation?.longitude ?? 0,
      busStopList: allBusStops,
    );

    // Get a stream of locations and filter the bus stops based on it
    // TODO: on the iPhone Simulator, when moving app to background and back to foreground, location is not fetched anymore?
    final locationStream = Geolocator.getPositionStream();
    await for (final locationData in locationStream) {
      // TODO: on Android emulator, it seems to constantly execute this, although the location doesn't change
      yield busDbService.filterNearbyBusStops(
        currentLatitude: locationData.latitude,
        currentLongitude: locationData.longitude,
        busStopList: allBusStops,
      );
    }
  }
}
