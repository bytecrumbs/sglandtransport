import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:lta_datamall_flutter/services/database_service.dart';
import 'package:lta_datamall_flutter/services/location_service.dart';

import 'models/bus_stop_model.dart';

final locationStreamProvider = StreamProvider.autoDispose<LocationData>((ref) {
  final locationService = ref.read(locationServiceProvider);

  return locationService.getLocationStream();
});

final nearbyBusStopsProvider =
    StreamProvider.autoDispose<List<BusStopModel>>((ref) async* {
  final databaseService = ref.read(databaseServiceProvider);
  final api = ref.read(apiProvider);

  var locationStream = ref.watch(locationStreamProvider.stream);

  // fetch all bus stops from DB
  var allBusStops = await databaseService.getBusStops();

  // if not populated, fetch from API and write result into DB
  if (allBusStops.isEmpty) {
    allBusStops = await api.fetchBusStopList();
    await databaseService.insertBusStops(allBusStops);
  }

  await for (var locationData in locationStream) {
    final nearbyBusStops = <BusStopModel>[];
    final distance = Distance();

    // filter DB result by location
    allBusStops.forEach((busStop) {
      final distanceInMeters = distance(
        LatLng(locationData.latitude, locationData.longitude),
        LatLng(busStop.latitude, busStop.longitude),
      );
      if (distanceInMeters <= 500) {
        final newBusStop =
            busStop.copyWith(distanceInMeters: distanceInMeters.round());

        nearbyBusStops.add(newBusStop);
      }
    });

    // sort result by distance
    nearbyBusStops.sort((BusStopModel a, BusStopModel b) =>
        a.distanceInMeters.compareTo(b.distanceInMeters));

    yield nearbyBusStops;
  }
});

class BusNearbyView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var locationData = useProvider(nearbyBusStopsProvider);

    return locationData.when(
      data: (busStopModelList) {
        if (busStopModelList.isEmpty) {
          return Center(
            child: Text('Looking for nearby Bus Stops'),
          );
        }
        return Center(
          child: Text('BusView ${busStopModelList.length}'),
        );
      },
      loading: () => Center(child: const CircularProgressIndicator()),
      error: (error, stack) => const Text('Oops'),
    );
  }
}
