import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/custom_exception.dart';
import '../shared/palette.dart';
import '../shared/widgets/error_display.dart';
import '../shared/widgets/staggered_animation.dart';
import 'bus_stop_page_view_model.dart';
import 'widgets/bus_arrival_card.dart';

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
    final _vm = ref
        .watch(busStopPageViewModelStateNotifierProvider(busStopCode).notifier);
    final _vmState =
        ref.watch(busStopPageViewModelStateNotifierProvider(busStopCode));

    return Scaffold(
      appBar: AppBar(
        title: Text(description),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kLoadSeatsAvailable,
                        width: 6, // Underline thickness
                      ),
                    ),
                  ),
                  child: const Text('Seats Avail.'),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kLoadStandingAvailable,
                        width: 6, // Underline thickness
                      ),
                    ),
                  ),
                  child: const Text('Standing Avail.'),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kLoadLimitedStanding,
                        width: 6, // Underline thickness
                      ),
                    ),
                  ),
                  child: const Text('Limited Standing'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _vmState.when(
              data: (busArrival) => AnimationLimiter(
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
          ),
        ],
      ),
    );
  }
}
