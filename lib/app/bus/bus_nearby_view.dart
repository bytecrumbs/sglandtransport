import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
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

  var locationStream = ref.watch(locationStreamProvider.stream);

  await for (var locationData in locationStream) {
    yield await databaseService.getNearbyBusStops(
        locationData.latitude, locationData.altitude);
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
          child: Text('BusView ${busStopModelList[0].busStopCode}'),
        );
      },
      loading: () => Center(child: const CircularProgressIndicator()),
      error: (error, stack) => const Text('Oops'),
    );
  }
}
