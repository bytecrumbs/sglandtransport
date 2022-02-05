import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/custom_exception.dart';
import '../../shared/widgets/error_display.dart';
import '../../shared/widgets/staggered_animation.dart';
import '../dashboard_page_view.dart';
import 'bus_stop_card.dart';
import 'bus_stop_list_nearby_view_model.dart';

class BusStopListNearbyView extends ConsumerWidget {
  const BusStopListNearbyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStops = ref.watch(busStopListNearbyViewModelStateNotifierProvider);

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
