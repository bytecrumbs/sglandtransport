import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/custom_exception.dart';
import '../shared/widgets/error_display.dart';
import '../shared/widgets/staggered_animation.dart';
import 'bus_repository.dart';
import 'bus_stop_page_view_model.dart';
import 'widgets/bus_arrival_card.dart';
import 'widgets/bus_stop_list_favorites_view.dart';

// checks if a given bus stop is a favorite bus stop
final isFavoriteBusStopStateProvider =
    StateProvider.autoDispose.family<bool, String>((ref, busStopCode) {
  final vm = ref.watch(busStopPageViewModelProvider);
  return vm.isFavoriteBusStop(busStopCode);
});

final _everyMinuteProvider = StreamProvider<void>((ref) {
  return Stream.periodic(const Duration(minutes: 1));
});

final busArrivalsFutureProvider = FutureProvider.family
    .autoDispose<List<BusArrivalServicesModel>, String>(
        (ref, busStopCode) async {
  // This ensures that the bus arrivals are fetched every minute
  ref.watch(_everyMinuteProvider);

  final vm = ref.watch(busStopPageViewModelProvider);
  return vm.getBusArrivals(busStopCode);
});

class BusStopPageView extends ConsumerWidget {
  const BusStopPageView({
    Key? key,
    required this.busStopCode,
    required this.description,
  }) : super(key: key);

  static const routeName = '/busStop';

  final String busStopCode;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busArrival = ref.watch(busArrivalsFutureProvider(busStopCode));
    final isFavoriteBusStopState =
        ref.watch(isFavoriteBusStopStateProvider(busStopCode));
    final isFavoriteBusStopController =
        ref.watch(isFavoriteBusStopStateProvider(busStopCode).notifier);
    final vm = ref.watch(busStopPageViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(description),
        actions: [
          IconButton(
            onPressed: () {
              isFavoriteBusStopController.state = !isFavoriteBusStopState;
              vm.toggleFavoriteBusStop(busStopCode);
              ref.refresh(favoriteBusStopsFutureProvider);
            },
            icon: isFavoriteBusStopState
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: busArrival.when(
        data: (busArrival) => RefreshIndicator(
          onRefresh: () {
            ref.refresh(busArrivalsFutureProvider(busStopCode));
            return ref.read(busArrivalsFutureProvider(busStopCode).future);
          },
          child: AnimationLimiter(
            child: ListView.builder(
              itemCount: busArrival.length,
              itemBuilder: (_, index) => StaggeredAnimation(
                index: index,
                child: BusArrivalCard(
                  busArrivalModel: busArrival[index],
                ),
              ),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          if (error is CustomException) {
            return ErrorDisplay(message: error.message);
          }
          return ErrorDisplay(
            message: error.toString(),
          );
        },
      ),
    );
  }
}
