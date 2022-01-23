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
                  itemCount: busArrival.services.length,
                  itemBuilder: (_, index) {
                    final currentBusArrivalServicesModel =
                        busArrival.services[index];
                    return StaggeredAnimation(
                      index: index,
                      child: BusArrivalCard(
                        inService: currentBusArrivalServicesModel.inService,
                        isFavorite: currentBusArrivalServicesModel.isFavorite,
                        serviceNo: currentBusArrivalServicesModel.serviceNo,
                        destinationName:
                            currentBusArrivalServicesModel.destinationName,
                        nextBusEstimatedArrival: currentBusArrivalServicesModel
                            .nextBus
                            .getEstimatedArrival(),
                        nextBusLoadDescription: currentBusArrivalServicesModel
                            .nextBus
                            .getLoadLongDescription(),
                        nextBusLoadColor: currentBusArrivalServicesModel.nextBus
                            .getLoadColor(),
                        nextBus2EstimatedArrival: currentBusArrivalServicesModel
                            .nextBus2
                            .getEstimatedArrival(),
                        nextBus2LoadDescription: currentBusArrivalServicesModel
                            .nextBus2
                            .getLoadLongDescription(),
                        nextBus2LoadColor: currentBusArrivalServicesModel
                            .nextBus2
                            .getLoadColor(),
                        nextBus3EstimatedArrival: currentBusArrivalServicesModel
                            .nextBus3
                            .getEstimatedArrival(),
                        nextBus3LoadDescription: currentBusArrivalServicesModel
                            .nextBus3
                            .getLoadLongDescription(),
                        nextBus3LoadColor: currentBusArrivalServicesModel
                            .nextBus3
                            .getLoadColor(),
                        onPressedFavorite: () {
                          _vm.toggleFavoriteBusService(
                            busStopCode: busStopCode,
                            serviceNo: busArrival.services[index].serviceNo,
                          );
                        },
                      ),
                    );
                  },
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
