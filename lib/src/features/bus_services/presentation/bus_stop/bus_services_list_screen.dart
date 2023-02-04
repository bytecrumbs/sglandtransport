import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../constants/bus_arrival_config.dart';
import '../../../../constants/palette.dart';
import '../../../../shared/custom_exception.dart';
import '../../../../shared/presentation/error_display.dart';
import '../../../../shared/presentation/staggered_animation.dart';
import '../../../bus_stops/domain/bus_stop_value_model.dart';
import '../../../bus_stops/presentation/bus_stop_card/bus_stop_card.dart';
import '../../../home/presentation/dashboard_screen.dart';
import '../../application/bus_services_service.dart';
import '../../domain/bus_arrival_model.dart';
import '../bus_service_card/bus_service_card.dart';

final busStopFutureProvider =
    FutureProvider.autoDispose.family<BusStopValueModel, String>(
  (ref, busStopCode) {
    final busServicesService = ref.watch(busServicesServiceProvider);
    return busServicesService.getBusStop(busStopCode);
  },
);

final busServicesStreamProvider =
    StreamProvider.autoDispose.family<BusArrivalModel, String>(
  (ref, busStopCode) async* {
    final busServicesService = ref.watch(busServicesServiceProvider);
    // make sure it is executed immediately
    yield await busServicesService.getBusArrivals(busStopCode);
    // then execute regularly
    yield* Stream.periodic(
      busArrivalRefreshDuration,
      (computationCount) {
        return busServicesService.getBusArrivals(busStopCode);
      },
    ).asyncMap((event) async => event);
  },
);

class BusServicesListScreen extends ConsumerWidget {
  const BusServicesListScreen({
    super.key,
    required this.busStopCode,
  });

  final String busStopCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vmState = ref.watch(
      busServicesStreamProvider(busStopCode),
    );

    final busStop = ref.watch(
      busStopFutureProvider(busStopCode),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Arrivals'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          busStop.when(
            data: (busStopValueModel) => ProviderScope(
              overrides: [
                busStopValueModelProvider.overrideWithValue(busStopValueModel),
              ],
              child: const BusStopCard(
                isBusArrival: true,
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) {
              if (error is CustomException) {
                return ErrorDisplay(
                  message: error.message,
                  onPressed: () {
                    ref.invalidate(
                      busServicesStreamProvider(
                        busStopCode,
                      ),
                    );
                  },
                );
              }
              return ErrorDisplay(
                message: error.toString(),
              );
            },
          ),
          Padding(
            // padding: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.only(bottom: 10),
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
                    busServicesStreamProvider(
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
                        key: Key(index.toString()),
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
                          isFavorite: currentBusArrivalServicesModel.isFavorite,
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
                      ref.invalidate(
                        busServicesStreamProvider(
                          busStopCode,
                        ),
                      );
                    },
                  );
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
