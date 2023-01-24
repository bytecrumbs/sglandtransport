import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../shared/custom_exception.dart';
import '../../../../shared/presentation/error_display.dart';
import '../../../../shared/presentation/staggered_animation.dart';
import '../bus_service_card/bus_service_card.dart';
import 'bus_service_header.dart';
import 'bus_service_list_favorites_controller.dart';

class BusServiceListFavorites extends ConsumerWidget {
  const BusServiceListFavorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vmState = ref.watch(busServiceListFavoritesControllerStateProvider);

    return vmState.when(
      data: (busArrivalModels) {
        if (busArrivalModels.isNotEmpty) {
          return AnimationLimiter(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final currentBusArrivalModel = busArrivalModels[index];
                  final currentBusArrivalServicesModel =
                      currentBusArrivalModel.services[0];
                  final previousBusStopCode = index == 0
                      ? '0'
                      : busArrivalModels[index - 1].busStopCode;
                  return StaggeredAnimation(
                    index: index,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (currentBusArrivalModel.busStopCode !=
                            previousBusStopCode)
                          BusServiceHeader(
                            busStopCode: currentBusArrivalModel.busStopCode,
                            description: currentBusArrivalModel.description,
                            roadName: currentBusArrivalModel.roadName,
                          ),
                        BusServiceCard(
                          busStopCode: currentBusArrivalModel.busStopCode,
                          previousBusStopCode: previousBusStopCode,
                          description: currentBusArrivalModel.description,
                          roadName: currentBusArrivalModel.roadName,
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
                      ],
                    ),
                  );
                },
                childCount: busArrivalModels.length,
              ),
            ),
          );
        } else {
          return SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Tap the favorites icon on any bus arrival to add '
                    'a bus to your favorites',
                  )
                ],
              ),
            ),
          );
        }
      },
      error: (error, stack) {
        if (error is CustomException) {
          return SliverFillRemaining(
            child: ErrorDisplay(
              message: error.message,
              onPressed: () {
                ref.invalidate(
                  busServiceListFavoritesControllerStateProvider,
                );
              },
            ),
          );
        }
        return SliverFillRemaining(
          child: ErrorDisplay(
            message: error.toString(),
            onPressed: () {
              ref.invalidate(
                busServiceListFavoritesControllerStateProvider,
              );
            },
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
