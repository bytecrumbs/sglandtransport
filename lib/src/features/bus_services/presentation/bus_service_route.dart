import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/custom_exception.dart';
import '../../../shared/data/local_db_repository.dart';
import '../../../shared/presentation/error_display.dart';
import '../../bus_routes/presentation/bus_route_tile.dart';
import '../../bus_stops/domain/bus_stop_value_model.dart';

part 'bus_service_route.g.dart';

@riverpod
Future<List<BusStopValueModel>> busStopValueModel(
  BusStopValueModelRef ref, {
  required String serviceNo,
  required String busStopCode,
}) {
  final repo = ref.watch(localDbRepositoryProvider);
  return repo.getBusRoute(
    serviceNo: serviceNo,
    busStopCode: busStopCode,
  );
}

class BusServiceRoute extends ConsumerWidget {
  const BusServiceRoute({
    super.key,
    required this.busStopCode,
    required this.serviceNo,
  });

  final String serviceNo;
  final String busStopCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStopValueModel = ref.watch(
      busStopValueModelProvider(
        serviceNo: serviceNo,
        busStopCode: busStopCode,
      ),
    );
    return Card(
      margin: const EdgeInsets.all(10),
      child: busStopValueModel.when(
        data: (busStop) => Column(
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
                itemCount: busStop.length,
                itemBuilder: (context, index) {
                  var busSequenceType = BusSequenceType.middle;

                  if (index == 0) {
                    busSequenceType = BusSequenceType.start;
                  } else if (index == busStop.length - 1) {
                    busSequenceType = BusSequenceType.end;
                  }

                  return BusRouteTile(
                    busStopCode: busStop[index].busStopCode,
                    roadName: busStop[index].roadName,
                    description: busStop[index].description,
                    busSequenceType: busSequenceType,
                  );
                },
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          if (error is CustomException) {
            return ErrorDisplay(
              message: error.message,
              onPressed: () {
                ref.invalidate(
                  busStopValueModelProvider(
                    serviceNo: serviceNo,
                    busStopCode: busStopCode,
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
