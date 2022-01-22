import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/custom_exception.dart';
import '../../shared/widgets/error_display.dart';
import '../../shared/widgets/staggered_animation.dart';
import 'bus_arrival_card.dart';
import 'bus_stop_list_favorites_view_model.dart';

class BusStopListFavoritesView extends ConsumerWidget {
  const BusStopListFavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _vmState = ref.watch(busStopListFavoritesViewModelStateProvider);

    return _vmState.when(
      data: (busServices) {
        if (busServices.isNotEmpty) {
          return AnimationLimiter(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => StaggeredAnimation(
                  index: index,
                  child: BusArrivalCard(
                    busArrivalModel: busServices[index],
                    onPressedFavorite: () {},
                  ),
                ),
                childCount: busServices.length,
              ),
            ),
          );
        } else {
          return const SliverFillRemaining(
            child: Center(child: Text('No favorites found...')),
          );
        }
      },
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
          child: Text('Looking for favorites...'),
        ),
      ),
    );
  }
}
