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
  // maintain the state, so that if it this provide is disposed and then called
  // again - while the user location is un-changed - it still shows the previous
  // bus stop list
  ref.maintainState = true;

  final db = ref.watch(busDatabaseServiceProvider);
  final allBusStops = await db.getBusStops();

  // TODO: on the iPhone Simulator, when moving app to background and back to foreground, location is not fetched anymore?
  final locationStream = Geolocator.getPositionStream();
  await for (final locationData in locationStream) {
    // filter DB result by location
    // TODO: can this somehow be done directly in the where clause of the getBusStops() method instead?
    final nearbyBusStops = <BusStopValueModel>[];
    for (final busStop in allBusStops) {
      final distanceInMeters = Geolocator.distanceBetween(
        locationData.latitude,
        locationData.longitude,
        busStop.latitude ?? 0,
        busStop.longitude ?? 0,
      );

      if (distanceInMeters <= 500) {
        final newBusStop = BusStopValueModel(
          busStopCode: busStop.busStopCode,
          description: busStop.description,
          roadName: busStop.roadName,
          latitude: busStop.latitude,
          longitude: busStop.longitude,
          distanceInMeters: distanceInMeters.round(),
        );

        nearbyBusStops.add(newBusStop);
      }
    }
    // sort result by distance
    nearbyBusStops.sort(
        (var a, var b) => a.distanceInMeters!.compareTo(b.distanceInMeters!));

    yield nearbyBusStops;
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
