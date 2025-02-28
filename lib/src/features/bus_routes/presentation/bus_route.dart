import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common_widgets/error_display.dart';
import '../../../custom_exception.dart';
import '../../../keys.dart';
import '../application/bus_routes_service.dart';
import '../domain/bus_route_with_bus_stop_info_model.dart';
import 'bus_route_tile.dart';

part 'bus_route.g.dart';

@riverpod
Future<List<BusRouteWithBusStopInfoModel>> busRouteWithBusStopInfoModel(
  BusRouteWithBusStopInfoModelRef ref, {
  required String serviceNo,
  required String busStopCode,
  required String destinationCode,
}) {
  final repo = ref.watch(busRoutesServiceProvider);
  return repo.getBusRoute(
    serviceNo: serviceNo,
    busStopCode: busStopCode,
    destinationCode: destinationCode,
  );
}

class BusRoute extends ConsumerWidget {
  const BusRoute({
    super.key,
    required this.busStopCode,
    required this.destinationCode,
    required this.serviceNo,
  });

  final String serviceNo;
  final String busStopCode;
  final String destinationCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busRouteWithBusStopInfoModel = ref.watch(
      busRouteWithBusStopInfoModelProvider(
        serviceNo: serviceNo,
        busStopCode: busStopCode,
        destinationCode: destinationCode,
      ),
    );
    return Card(
      child: busRouteWithBusStopInfoModel.when(
        data: (busRoute) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Route',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: busRoute.length,
                itemBuilder: (context, index) {
                  var busSequenceType = BusSequenceType.middle;

                  if (index == 0) {
                    busSequenceType = BusSequenceType.start;
                  } else if (index == busRoute.length - 1) {
                    busSequenceType = BusSequenceType.end;
                  }

                  return BusRouteTile(
                    busStopCode: busRoute[index].busStopCode,
                    roadName: busRoute[index].roadName,
                    description: busRoute[index].description,
                    busSequenceType: busSequenceType,
                    isPreviousStops: busRoute[index].isPreviousStops,
                  );
                },
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(
            key: loadingIndicatorKey,
          ),
        ),
        error: (error, stack) {
          if (error is CustomException) {
            return ErrorDisplay(
              message: error.message,
              onPressed: () {
                ref.invalidate(
                  busRouteWithBusStopInfoModelProvider(
                    serviceNo: serviceNo,
                    busStopCode: busStopCode,
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
    );
  }
}
