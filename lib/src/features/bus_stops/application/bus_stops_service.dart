import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../third_party_providers/third_party_providers.dart';
import '../../../user_location/location_service.dart';
import '../data/bus_stops_repository.dart';
import '../domain/bus_stop_value_model.dart';

part 'bus_stops_service.g.dart';

@Riverpod(keepAlive: true)
BusStopsService busStopsService(BusStopsServiceRef ref) => BusStopsService(ref);

class BusStopsService {
  BusStopsService(this.ref);

  final Ref ref;

  Future<List<BusStopValueModel>> getNearbyBusStops({
    double? latitude,
    double? longitude,
  }) async {
    final busLocalRepository = ref.read(busStopsRepositoryProvider);

    // fetch all bus stops from the database and then filter based on the cached
    // result. This is more efficient than querying the local database with a filter
    // every time the location changes, I think... :-)
    final allBusStops = await busLocalRepository.getAllBusStops();

    ref.read(loggerProvider).d('Filtering bus stops based on location');
    final nearbyBusStops = <BusStopValueModel>[];
    if (latitude != null && longitude != null) {
      for (final busStop in allBusStops) {
        final distanceInMeters =
            ref.read(locationServiceProvider).getDistanceInMeters(
                  startLatitude: latitude,
                  startLongitude: longitude,
                  endLatitude: busStop.latitude,
                  endLongitude: busStop.longitude,
                );

        if (distanceInMeters <= 500) {
          nearbyBusStops.add(
            busStop.copyWith(
              distanceInMeters: distanceInMeters.round(),
            ),
          );
        }
      }
      // sort result by distance
      nearbyBusStops.sort(
        (var a, var b) => a.distanceInMeters!.compareTo(b.distanceInMeters!),
      );
    }

    return nearbyBusStops;
  }
}
