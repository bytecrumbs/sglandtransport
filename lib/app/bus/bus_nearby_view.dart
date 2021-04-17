import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';

import '../../common_widgets/error_view.dart';
import '../../common_widgets/staggered_animation.dart';
import '../../services/location_service.dart';
import '../failure.dart';
import 'bus_nearby_viewmodel.dart';
import 'bus_stop_card.dart';
import 'models/bus_stop_model.dart';

/// Provides a stream of user location information
final locationStreamProvider = StreamProvider.autoDispose<LocationData>((ref) {
  final locationService = ref.read(locationServiceProvider);

  return locationService.getLocationStream();
});

/// Provides a stream of nearby bus stops, based on
/// user location
final nearbyBusStopsProvider =
    StreamProvider.autoDispose<List<BusStopModel>>((ref) async* {
  final vm = ref.read(busNearbyViewModelProvider);

  final allBusStops = await vm.getBusStops();

  // filter and yield a value whenever a new location is provided via the
  // location stream
  final locationStream = ref.watch(locationStreamProvider.stream);
  await for (final locationData in locationStream) {
    yield vm.filterBusStopsByLocation(
        allBusStops, locationData.latitude ?? 0, locationData.longitude ?? 0);
  }
});

/// The main view that shows nearby bus stops
class BusNearbyView extends HookWidget {
  /// Default Constructor
  const BusNearbyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationData = useProvider(nearbyBusStopsProvider);

    return locationData.when(
      data: (busStopModelList) {
        if (busStopModelList.isEmpty) {
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: const <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Looking for nearby bus stops...'),
              ],
            ),
          );
        }
        return AnimationLimiter(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: busStopModelList.length,
              itemBuilder: (context, index) {
                return StaggeredAnimation(
                  index: index,
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: BusStopCard(
                      busStopModel: busStopModelList[index],
                      key: ValueKey<String>('busStopCard-$index'),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      loading: () =>
          const Center(child: Text('Looking for nearby bus stops...')),
      error: (err, stack) {
        if (err is Failure) {
          return ErrorView(message: err.message);
        }
        return const ErrorView(
          message: 'Something unexpected happened!',
        );
      },
    );
  }
}
