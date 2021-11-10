import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/common_providers.dart';
import '../../shared/custom_exception.dart';
import '../../shared/widgets/error_display.dart';
import '../../shared/widgets/staggered_animation.dart';
import '../bus_repository.dart';
import '../bus_stop_list_page_view.dart';
import 'bus_stop_card.dart';
import 'bus_stop_list_nearby_view_model.dart';

final busStopsStreamProvider = FutureProvider.autoDispose
    .family<List<BusStopValueModel>, Position?>((ref, position) async {
  final vm = ref.watch(busStopListNearbyViewModelProvider);
  return vm.getNearbyBusStops(
    latitude: position?.latitude ?? 0,
    longitude: position?.longitude ?? 0,
  );
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
  late StreamSubscription _subscription;
  Position? _position;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    ref.read(loggerProvider).d('starting location stream');
    _subscription = Geolocator.getPositionStream(
            intervalDuration: const Duration(seconds: 1))
        .listen((event) {
      setState(() {
        _position = event;
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _subscription.cancel();
    // uncomment the below to debug. for some reason, it is throwing error
    // when trying to use ref.read(loggerProvider)...
    // print('cancelling location stream');
    super.dispose();
  }

  // Ensure location starts to stream again, when the app comes back from the
  // background
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(loggerProvider).d('restarting location stream');
      _subscription.cancel();
      _subscription = Geolocator.getPositionStream(
              intervalDuration: const Duration(seconds: 1))
          .listen((event) {
        setState(() {
          _position = event;
        });
      });
      // ref.refresh(busStopsStreamProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final busStops = ref.watch(busStopsStreamProvider(_position));

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
