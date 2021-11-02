import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lta_datamall_flutter/src/bus_stop/bus_database_service.dart';

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
    // the device has not changed since last time it was called
    final currentLocation = await Geolocator.getCurrentPosition();
    yield busDbService.filterNearbyBusStops(
      currentLatitude: currentLocation.latitude,
      currentLongitude: currentLocation.longitude,
      busStopList: allBusStops,
    );

    // Get a stream of locations and filter the bus stops based on it
    // TODO: on the iPhone Simulator, when moving app to background and back to foreground, location is not fetched anymore?
    final locationStream = Geolocator.getPositionStream();
    await for (final locationData in locationStream) {
      yield busDbService.filterNearbyBusStops(
        currentLatitude: locationData.latitude,
        currentLongitude: locationData.longitude,
        busStopList: allBusStops,
      );
    }
  }
}
