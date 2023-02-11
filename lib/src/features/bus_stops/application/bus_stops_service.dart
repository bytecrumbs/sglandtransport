import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/data/local_db_repository.dart';
import '../../../shared/third_party_providers.dart';
import '../../user_location/application/location_service.dart';
import '../domain/bus_stop_value_model.dart';

final busStopsServiceProvider = Provider<BusStopsService>(BusStopsService.new);

class BusStopsService {
  BusStopsService(this._ref);

  final Ref _ref;

  Future<List<BusStopValueModel>> getNearbyBusStops({
    double? latitude,
    double? longitude,
  }) async {
    final busLocalRepository = _ref.read(busLocalRepositoryProvider);

    // fetch all bus stops from the database and then filter based on the cached
    // result. This is more efficient than querying the local database with a filter
    // every time the location changes, I think... :-)
    final allBusStops = await busLocalRepository.getAllBusStops();

    _ref.read(loggerProvider).d('Filtering bus stops based on location');
    final nearbyBusStops = <BusStopValueModel>[];
    if (latitude != null && longitude != null) {
      for (final busStop in allBusStops) {
        final distanceInMeters =
            _ref.read(locationServiceProvider).getDistanceInMeters(
                  startLatitude: latitude,
                  startLongitude: longitude,
                  endLatitude: busStop.latitude ?? 0,
                  endLongitude: busStop.longitude ?? 0,
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
