import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../shared/custom_exception.dart';
import '../shared/error_display.dart';
import 'bus_database_service.dart';
import 'bus_repository.dart';
import 'widgets/bus_stop_card.dart';

final busStopsStreamProvider =
    StreamProvider.autoDispose<List<BusStopValueModel>>((ref) async* {
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
        // 1.42117943692586,
        // 103.831477233098,
        locationData.latitude,
        locationData.longitude,
        busStop.latitude ?? 0,
        busStop.longitude ?? 0,
      );

      if (distanceInMeters <= 500) {
        final newBusStop = BusStopValueModel(
          busStopCode: busStop.busStopCode,
          descritption: busStop.description,
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

class BusStopListPage extends ConsumerWidget {
  const BusStopListPage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStops = ref.watch(busStopsStreamProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Bus'),
            expandedHeight: 200,
          ),
          busStops.when(
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
          ),
        ],
      ),
    );
  }
}
