import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../constants/palette.dart';
import '../../../../shared/custom_exception.dart';
import '../../../../shared/presentation/error_display.dart';
import '../../../../shared/presentation/staggered_animation.dart';
import '../bus_service_card/bus_service_card.dart';
import 'bus_services_list_screen_controller.dart';

class BusServicesListScreen extends ConsumerWidget {
  const BusServicesListScreen({
    super.key,
    required this.busStopCode,
    required this.description,
  });

  static const routeName = '/busStop';

  final String busStopCode;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vmState = ref.watch(
      busServicesListScreenControllerStateNotifierProvider(busStopCode),
    );
    final vm = ref.watch(
      busServicesListScreenControllerStateNotifierProvider(busStopCode)
          .notifier,
    );

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
              children: const [
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kLoadSeatsAvailable,
                        width: 6, // Underline thickness
                      ),
                    ),
                  ),
                  child: Text('Seats Avail.'),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kLoadStandingAvailable,
                        width: 6, // Underline thickness
                      ),
                    ),
                  ),
                  child: Text('Standing Avail.'),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: kLoadLimitedStanding,
                        width: 6, // Underline thickness
                      ),
                    ),
                  ),
                  child: Text('Limited Standing'),
                ),
              ],
            ),
          ),
          Expanded(
            child: vmState.when(
              data: (busArrival) => RefreshIndicator(
                onRefresh: () {
                  ref.invalidate(
                    busServicesListScreenControllerStateNotifierProvider(
                      busStopCode,
                    ),
                  );
                  return Future.value();
                },
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: busArrival.services.length,
                    itemBuilder: (_, index) {
                      final currentBusArrivalServicesModel =
                          busArrival.services[index];
                      return StaggeredAnimation(
                        index: index,
                        child: BusServiceCard(
                          busStopCode: busStopCode,
                          inService: currentBusArrivalServicesModel.inService,
                          serviceNo: currentBusArrivalServicesModel.serviceNo,
                          destinationName:
                              currentBusArrivalServicesModel.destinationName,
                          nextBusEstimatedArrival:
                              currentBusArrivalServicesModel.nextBus
                                  .getEstimatedArrival(),
                          nextBusLoadColor: currentBusArrivalServicesModel
                              .nextBus
                              .getLoadColor(),
                          nextBus2EstimatedArrival:
                              currentBusArrivalServicesModel.nextBus2
                                  .getEstimatedArrival(),
                          nextBus2LoadColor: currentBusArrivalServicesModel
                              .nextBus2
                              .getLoadColor(),
                          nextBus3EstimatedArrival:
                              currentBusArrivalServicesModel.nextBus3
                                  .getEstimatedArrival(),
                          nextBus3LoadColor: currentBusArrivalServicesModel
                              .nextBus3
                              .getLoadColor(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) {
                if (error is CustomException) {
                  return ErrorDisplay(
                    message: error.message,
                    onPressed: () {
                      vm.init(isRefreshing: true);
                    },
                  );
                }
                return ErrorDisplay(
                  message: error.toString(),
                  onPressed: () {
                    vm.init(isRefreshing: true);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
