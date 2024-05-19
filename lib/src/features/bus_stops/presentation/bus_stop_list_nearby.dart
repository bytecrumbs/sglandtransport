import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common_widgets/error_display.dart';
import '../../../common_widgets/main_content_margin.dart';
import '../../../common_widgets/staggered_animation.dart';
import '../../../custom_exception.dart';
import '../../../database/db_init_notifier.dart';
import '../../../user_location/location_service.dart';
import '../../home/presentation/dashboard_screen.dart';
import '../application/bus_stops_service.dart';
import '../domain/bus_stop_value_model.dart';
import 'bus_stop_card/bus_stop_card.dart';
import 'bus_stop_list_loading.dart';

part 'bus_stop_list_nearby.g.dart';

@riverpod
Stream<List<BusStopValueModel>> nearbyBusStopsStream(
  NearbyBusStopsStreamRef ref,
) async* {
  final locationService = ref.watch(locationServiceProvider);

  // TODO: can this be done on startup, rather than repeating it in all the
  // providers that make use of the location service?
  final hasPermission = await locationService.handlePermission();

  if (hasPermission) {
    final locationStream = locationService.startLocationStream();

    ref.onDispose(locationService.stopLocationStream);

    // Yield the bus stops of the last known position, if current position
    // has not changed since last time the widget was called
    final currentPosition = await locationService.getLastKnownPosition();
    yield await ref.watch(busStopsServiceProvider).getNearbyBusStops(
          latitude: currentPosition.latitude,
          longitude: currentPosition.longitude,
        );

    // Yield updated positions
    await for (final locationData in locationStream) {
      yield await ref.watch(busStopsServiceProvider).getNearbyBusStops(
            latitude: locationData.latitude,
            longitude: locationData.longitude,
          );
    }
  } else {
    throw Exception('No permission to access location');
  }
}

class BusStopListNearby extends ConsumerWidget {
  const BusStopListNearby({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStops = ref.watch(nearbyBusStopsStreamProvider);

    return busStops.when(
      data: (busStops) => AnimationLimiter(
        child: SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => MainContentMargin(
              child: StaggeredAnimation(
                index: index,
                child: ProviderScope(
                  overrides: [
                    busStopValueModelProvider
                        .overrideWithValue(busStops[index]),
                  ],
                  child: const Column(
                    children: [
                      BusStopCard(),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
            childCount: busStops.length,
          ),
        ),
      ),
      error: (error, stack) {
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
      loading: BusStopListLoading.new,
    );
  }
}
