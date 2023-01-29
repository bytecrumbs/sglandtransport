import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../constants/bus_arrival_config.dart';
import '../../../../shared/custom_exception.dart';
import '../../../../shared/presentation/error_display.dart';
import '../../../../shared/presentation/staggered_animation.dart';
import '../../application/bus_services_service.dart';
import '../../domain/bus_arrival_with_bus_stop_model.dart';
import '../bus_service_card/bus_service_card.dart';
import 'bus_service_header.dart';

final favoriteBusServicesStreamProvider =
    StreamProvider.autoDispose<List<BusArrivalWithBusStopModel>>(
  (ref) async* {
    final busServicesService = ref.watch(busServicesServiceProvider);
    // make sure it is executed immediately
    yield await busServicesService.getFavoriteBusServices();
    // then execute regularly
    yield* Stream.periodic(
      busArrivalRefreshDuration,
      (computationCount) {
        return busServicesService.getFavoriteBusServices();
      },
    ).asyncMap((event) async => event);
  },
);

class BusServiceListFavorites extends ConsumerWidget {
  const BusServiceListFavorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vmState = ref.watch(favoriteBusServicesStreamProvider);

    return vmState.when(
      data: (busArrivalWithBusStopModels) {
        if (busArrivalWithBusStopModels.isNotEmpty) {
          return AnimationLimiter(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final currentBusArrivalWithBusStopModel =
                      busArrivalWithBusStopModels[index];

                  return StaggeredAnimation(
                    index: index,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BusServiceHeader(
                          busStopCode: currentBusArrivalWithBusStopModel
                              .busStopValueModel.busStopCode,
                          description: currentBusArrivalWithBusStopModel
                              .busStopValueModel.description,
                          roadName: currentBusArrivalWithBusStopModel
                              .busStopValueModel.roadName,
                          distanceInMeters: currentBusArrivalWithBusStopModel
                              .busStopValueModel.distanceInMeters,
                        ),
                        Column(
                          children: currentBusArrivalWithBusStopModel.services
                              .map(
                                (busArrivalServiceModel) => BusServiceCard(
                                  busStopCode: currentBusArrivalWithBusStopModel
                                      .busStopValueModel.busStopCode!,
                                  inService: busArrivalServiceModel.inService,
                                  serviceNo: busArrivalServiceModel.serviceNo,
                                  destinationName:
                                      busArrivalServiceModel.destinationName,
                                  nextBusEstimatedArrival:
                                      busArrivalServiceModel.nextBus
                                          .getEstimatedArrival(),
                                  nextBusLoadColor: busArrivalServiceModel
                                      .nextBus
                                      .getLoadColor(),
                                  nextBus2EstimatedArrival:
                                      busArrivalServiceModel.nextBus2
                                          .getEstimatedArrival(),
                                  nextBus2LoadColor: busArrivalServiceModel
                                      .nextBus2
                                      .getLoadColor(),
                                  nextBus3EstimatedArrival:
                                      busArrivalServiceModel.nextBus3
                                          .getEstimatedArrival(),
                                  nextBus3LoadColor: busArrivalServiceModel
                                      .nextBus3
                                      .getLoadColor(),
                                  isFavorite: busArrivalServiceModel.isFavorite,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  );
                },
                childCount: busArrivalWithBusStopModels.length,
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
                  favoriteBusServicesStreamProvider,
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
                favoriteBusServicesStreamProvider,
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
