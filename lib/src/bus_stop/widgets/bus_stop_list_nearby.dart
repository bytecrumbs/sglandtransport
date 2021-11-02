import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../shared/custom_exception.dart';
import '../../shared/error_display.dart';
import '../bus_database_service.dart';
import '../bus_repository.dart';
import 'bus_stop_card.dart';

final busStopsStreamProvider =
    StreamProvider.autoDispose<List<BusStopValueModel>>((ref) async* {
  final busDbService = ref.watch(busDatabaseServiceProvider);

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
});

class BusStopListNearby extends ConsumerWidget {
  const BusStopListNearby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStops = ref.watch(busStopsStreamProvider);
    return busStops.when(
      data: (busStops) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => BusStopCard(
            busStopValueModel: busStops[index],
          ),
          childCount: busStops.length,
        ),
      ),
      error: (error, stack, _) {
        if (error is CustomException) {
          return SliverFillRemaining(
            child: ErrorDisplay(message: error.message),
          );
        }
        return SliverFillRemaining(
          child: ErrorDisplay(
            message: error.toString(),
          ),
        );
      },
      loading: (_) => const SliverFillRemaining(
        child: Center(
          child: Text('Looking for nearby bus stops...'),
        ),
      ),
    );
  }
}
