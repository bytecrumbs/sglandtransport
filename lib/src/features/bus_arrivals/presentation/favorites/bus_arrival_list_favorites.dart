import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common_widgets/error_display.dart';
import '../../../../common_widgets/main_content_margin.dart';
import '../../../../common_widgets/staggered_animation.dart';
import '../../../../custom_exception.dart';
import '../../application/bus_arrivals_service.dart';
import '../../domain/bus_arrival_with_bus_stop_model.dart';
import '../bus_arrival_card/bus_arrival_card.dart';
import '../bus_arrival_config.dart';
import 'bus_arrival_header.dart';

part 'bus_arrival_list_favorites.g.dart';

@riverpod
Stream<List<BusArrivalWithBusStopModel>> favoriteBusArrivalsStream(
  Ref ref,
) async* {
  final busServicesService = ref.watch(busArrivalsServiceProvider);

  // handleLegacyFavorites is only required temporarily and can be removed
  // again in a later version, as it migrates the old bus stop favorites
  // to the new way we are storing bus services in favorites
  // maybe we can delete this code again after a few releases
  await busServicesService.handleLegacyFavorites();

  // make sure it is executed immediately
  yield await busServicesService.getFavoriteBusServices();
  // then execute regularly
  yield* Stream.periodic(busArrivalRefreshDuration, (computationCount) {
    return busServicesService.getFavoriteBusServices();
  }).asyncMap((event) async => event);
}

class BusArrivalListFavorites extends ConsumerWidget {
  const BusArrivalListFavorites({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vmState = ref.watch(favoriteBusArrivalsStreamProvider);

    return vmState.when(
      data: (busArrivalWithBusStopModels) {
        if (busArrivalWithBusStopModels.isNotEmpty) {
          return AnimationLimiter(
            child: SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
                final currentBusArrivalWithBusStopModel =
                    busArrivalWithBusStopModels[index];

                return MainContentMargin(
                  child: StaggeredAnimation(
                    index: index,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BusArrivalHeader(
                          busStopCode: currentBusArrivalWithBusStopModel
                              .busStopValueModel
                              .busStopCode,
                          description: currentBusArrivalWithBusStopModel
                              .busStopValueModel
                              .description,
                          roadName: currentBusArrivalWithBusStopModel
                              .busStopValueModel
                              .roadName,
                          distanceInMeters: currentBusArrivalWithBusStopModel
                              .busStopValueModel
                              .distanceInMeters,
                        ),
                        Column(
                          children: currentBusArrivalWithBusStopModel.services
                              .map(
                                (busArrivalServiceModel) => BusArrivalCard(
                                  busStopCode: currentBusArrivalWithBusStopModel
                                      .busStopValueModel
                                      .busStopCode,
                                  destinationCode:
                                      busArrivalServiceModel
                                          .nextBus
                                          .destinationCode ??
                                      '1',
                                  inService: busArrivalServiceModel.inService,
                                  serviceNo: busArrivalServiceModel.serviceNo,
                                  destinationName:
                                      busArrivalServiceModel.destinationName,
                                  nextBusEstimatedArrival:
                                      busArrivalServiceModel.nextBus
                                          .getEstimatedArrival(),
                                  nextBusLoad:
                                      busArrivalServiceModel.nextBus.load ??
                                      'SEQ',
                                  nextBus2EstimatedArrival:
                                      busArrivalServiceModel.nextBus2
                                          .getEstimatedArrival(),
                                  nextBus2Load:
                                      busArrivalServiceModel.nextBus2.load ??
                                      'SEQ',
                                  nextBus3EstimatedArrival:
                                      busArrivalServiceModel.nextBus3
                                          .getEstimatedArrival(),
                                  nextBus3Load:
                                      busArrivalServiceModel.nextBus3.load ??
                                      'SEQ',
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              }, childCount: busArrivalWithBusStopModels.length),
            ),
          );
        } else {
          return const SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tap the favorites icon on any bus arrival to add '
                    'a bus to your favorites',
                  ),
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
                ref.invalidate(favoriteBusArrivalsStreamProvider);
              },
            ),
          );
        }
        return SliverFillRemaining(
          child: ErrorDisplay(
            message: error.toString(),
            onPressed: () {
              ref.invalidate(favoriteBusArrivalsStreamProvider);
            },
          ),
        );
      },
      loading: () => const SliverFillRemaining(
        child: Center(child: Text('Looking for favorites...')),
      ),
    );
  }
}
