import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/custom_exception.dart';
import '../../shared/widgets/error_display.dart';
import '../bus_stop_list_page_view.dart';
import 'bus_stop_card.dart';
import 'bus_stop_list_favorites_view_model.dart';

final favoriteBusStopsFutureProvider = FutureProvider.autoDispose((ref) async {
  final vm = ref.watch(busStopListFavoritesViewModelProvider);
  return vm.getFavoriteBusStops();
});

class BusStopListFavoritesView extends ConsumerWidget {
  const BusStopListFavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStops = ref.watch(favoriteBusStopsFutureProvider);
    return busStops.when(
      data: (busStops) {
        if (busStops.isNotEmpty) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => ProviderScope(
                overrides: [
                  busStopValueModelProvider.overrideWithValue(busStops[index])
                ],
                child: const BusStopCard(),
              ),
              childCount: busStops.length,
            ),
          );
        } else {
          return const SliverFillRemaining(
            child: Center(child: Text('No favorite bus stops found...')),
          );
        }
      },
      error: (error, stack, _) {
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
      loading: (_) => const SliverFillRemaining(
        child: Center(
          child: Text('Looking for favorite bus stops...'),
        ),
      ),
    );
  }
}
