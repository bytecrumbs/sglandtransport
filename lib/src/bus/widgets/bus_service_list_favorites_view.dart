import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/custom_exception.dart';
import '../../shared/widgets/error_display.dart';
import '../../shared/widgets/staggered_animation.dart';
import 'bus_service_card.dart';
import 'bus_service_list_favorites_view_model.dart';

class BusServiceListFavoritesView extends ConsumerWidget {
  const BusServiceListFavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vmState = ref.watch(busServiceListFavoritesViewModelStateProvider);
    final vm =
        ref.watch(busServiceListFavoritesViewModelStateProvider.notifier);

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
                  return StaggeredAnimation(
                    index: index,
                    child: BusServiceCard(
                      busStopCode: currentBusArrivalModel.busStopCode,
                      description: currentBusArrivalModel.description,
                      roadName: currentBusArrivalModel.roadName,
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
                      nextBusLoadColor:
                          currentBusArrivalServicesModel.nextBus.getLoadColor(),
                      nextBus2EstimatedArrival: currentBusArrivalServicesModel
                          .nextBus2
                          .getEstimatedArrival(),
                      nextBus2LoadDescription: currentBusArrivalServicesModel
                          .nextBus2
                          .getLoadLongDescription(),
                      nextBus2LoadColor: currentBusArrivalServicesModel.nextBus2
                          .getLoadColor(),
                      nextBus3EstimatedArrival: currentBusArrivalServicesModel
                          .nextBus3
                          .getEstimatedArrival(),
                      nextBus3LoadDescription: currentBusArrivalServicesModel
                          .nextBus3
                          .getLoadLongDescription(),
                      nextBus3LoadColor: currentBusArrivalServicesModel.nextBus3
                          .getLoadColor(),
                      onPressedFavorite: () {},
                      onDismissed: () {
                        vm.removeFavorite(
                          busStopCode: currentBusArrivalModel.busStopCode,
                          serviceNo: currentBusArrivalServicesModel.serviceNo,
                        );
                      },
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
                    'To add a bus to your favorites, swipe right on any '
                    'bus arrival tile and tap the favorites icon.',
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
