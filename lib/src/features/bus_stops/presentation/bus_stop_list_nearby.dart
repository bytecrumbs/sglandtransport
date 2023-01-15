import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../shared/custom_exception.dart';
import '../../../shared/presentation/error_display.dart';
import '../../../shared/presentation/staggered_animation.dart';
import '../../../shared/third_party_providers.dart';
import '../../home/presentation/dashboard_screen.dart';
import 'bus_stop_card/bus_stop_card.dart';
import 'bus_stop_list_nearby_controller.dart';

class BusStopListNearby extends ConsumerStatefulWidget {
  const BusStopListNearby({super.key});

  @override
  @override
  BusStopListNearbyState createState() => BusStopListNearbyState();
}

class BusStopListNearbyState extends ConsumerState<BusStopListNearby>
    with
        // ignore: prefer_mixin
        WidgetsBindingObserver {
  bool streamIsPaused = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Ensure location starts to stream again, when the app comes back from the
    // background
    if (state == AppLifecycleState.resumed && streamIsPaused) {
      ref.read(loggerProvider).d('restarting location stream');
      ref
          .read(busStopListNearbyControllerStateNotifierProvider.notifier)
          .startLocationStream();
      streamIsPaused = false;

      // Stop streaming the location when the app goes into the background
    } else if (state == AppLifecycleState.paused) {
      ref.read(loggerProvider).d('stopping location stream');
      ref
          .read(busStopListNearbyControllerStateNotifierProvider.notifier)
          .stopLocationStream();
      streamIsPaused = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final busStops =
        ref.watch(busStopListNearbyControllerStateNotifierProvider);

    return busStops.when(
      data: (busStops) => AnimationLimiter(
        child: SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) => StaggeredAnimation(
              index: index,
              child: ProviderScope(
                overrides: [
                  busStopValueModelProvider.overrideWithValue(busStops[index]),
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
}
