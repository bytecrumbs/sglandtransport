import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/common_providers.dart';
import '../../shared/custom_exception.dart';
import '../../shared/widgets/error_display.dart';
import '../../shared/widgets/staggered_animation.dart';
import '../dashboard_page_view.dart';
import 'bus_stop_card.dart';
import 'bus_stop_list_nearby_view_model.dart';

final locationStreamProvider = StreamProvider.autoDispose((ref) {
  final vm = ref.watch(busStopListNearbyViewModelProvider);
  ref.onDispose(vm.stopLocationStream);
  return vm.getLocationStream();
});

final busStopsStreamProvider = StreamProvider.autoDispose((ref) async* {
  final locationStream = ref.watch(locationStreamProvider.stream);
  final vm = ref.watch(busStopListNearbyViewModelProvider);

  await for (final locationData in locationStream) {
    yield await vm.getNearbyBusStops(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
    );
  }
});

final locationPermissionFutureProvider = FutureProvider<bool>((ref) {
  final vm = ref.watch(busStopListNearbyViewModelProvider);
  return vm.handleLocationPermission();
});

class BusStopListNearbyView extends ConsumerStatefulWidget {
  const BusStopListNearbyView({Key? key}) : super(key: key);

  @override
  BusStopListNearbyViewState createState() => BusStopListNearbyViewState();
}

class BusStopListNearbyViewState extends ConsumerState<BusStopListNearbyView>
    with
        // ignore: prefer_mixin
        WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // Ensure location starts to stream again, when the app comes back from the
  // background
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(loggerProvider).d('restarting location stream');
      ref.refresh(locationStreamProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPermission = ref.watch(locationPermissionFutureProvider);

    return hasPermission.when(
      data: (hasPermision) {
        if (!hasPermision) {
          return const SliverFillRemaining(
            child: ErrorDisplay(
              message:
                  'Permission for location tracking disabled on this device',
            ),
          );
        } else {
          final busStops = ref.watch(busStopsStreamProvider);

          return busStops.when(
            data: (busStops) => AnimationLimiter(
              child: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) => StaggeredAnimation(
                    index: index,
                    child: ProviderScope(
                      overrides: [
                        busStopValueModelProvider
                            .overrideWithValue(busStops[index]),
                      ],
                      child: const BusStopCard(),
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
            loading: () => const SliverFillRemaining(
              child: Center(
                child: Text('Looking for nearby bus stops...'),
              ),
            ),
          );
        }
      },
      error: (error, stack) => SliverFillRemaining(
        child: ErrorDisplay(
          message: error.toString(),
        ),
      ),
      loading: () => const SliverFillRemaining(
        child: Center(
          child: Text('Checking device permission for location...'),
        ),
      ),
    );
  }
}
