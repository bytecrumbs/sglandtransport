import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/custom_exception.dart';
import '../../../../shared/presentation/error_display.dart';
import '../../../bus_stops/domain/bus_stop_value_model.dart';
import '../../../bus_stops/presentation/bus_stop_card/bus_stop_card.dart';
import '../../../home/presentation/dashboard_screen.dart';
import '../../application/bus_arrivals_service.dart';
import '../bus_arrival_card/bus_arrival_card_with_fetch.dart';

part 'bus_route_screen.g.dart';

@riverpod
Future<List<BusStopValueModel>> busRoute(
  BusRouteRef ref, {
  required String busStopCode,
  required String serviceNo,
  required String originalCode,
  required String destinationCode,
}) {
  final service = ref.watch(busArrivalsServiceProvider);
  return service.getBusRoute(
    busStopCode: busStopCode,
    serviceNo: serviceNo,
    originalCode: originalCode,
    destinationCode: destinationCode,
  );
}

class BusRouteScreen extends ConsumerWidget {
  const BusRouteScreen({
    super.key,
    required this.serviceNo,
    required this.busStopCode,
    required this.originalCode,
    required this.destinationCode,
  });

  final String serviceNo;
  final String busStopCode;
  final String originalCode;
  final String destinationCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busRoute = ref.watch(
      busRouteProvider(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
        originalCode: originalCode,
        destinationCode: destinationCode,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Route'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          BusArrivalCardWithFetch(
            busStopCode: busStopCode,
            serviceNo: serviceNo,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: busRoute.when(
              data: (busStopValueModelList) => ListView.separated(
                itemCount: busStopValueModelList.length,
                itemBuilder: (_, index) {
                  return ProviderScope(
                    overrides: [
                      busStopValueModelProvider
                          .overrideWithValue(busStopValueModelList[index]),
                    ],
                    child: const BusStopCard(),
                  );
                },
                separatorBuilder: (context, index) =>
                    const Icon(Icons.arrow_downward),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) {
                if (error is CustomException) {
                  return ErrorDisplay(
                    message: error.message,
                    onPressed: () {
                      ref.invalidate(
                        busRouteProvider(
                          busStopCode: busStopCode,
                          serviceNo: serviceNo,
                          originalCode: originalCode,
                          destinationCode: destinationCode,
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
