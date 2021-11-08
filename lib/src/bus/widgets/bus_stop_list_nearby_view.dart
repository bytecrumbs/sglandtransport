import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/custom_exception.dart';
import '../../shared/widgets/error_display.dart';
import '../../shared/widgets/staggered_animation.dart';
import '../bus_repository.dart';
import '../bus_stop_list_page_view.dart';
import 'bus_stop_card.dart';
import 'bus_stop_list_nearby_view_model.dart';

final busStopsStreamProvider =
    StreamProvider.autoDispose<List<BusStopValueModel>>((ref) {
  final vm = ref.watch(busStopListNearbyViewModelProvider);
  return vm.streamBusStops();
});

// class BusStopListNearbyView extends StatefulWidget {
//   const BusStopListNearbyView({ Key? key }) : super(key: key);

//   @override
//   _BusStopListNearbyViewState createState() => _BusStopListNearbyViewState();
// }

// class _BusStopListNearbyViewState extends State<BusStopListNearbyView> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

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
      ref.refresh(busStopsStreamProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final busStops = ref.watch(busStopsStreamProvider);
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
