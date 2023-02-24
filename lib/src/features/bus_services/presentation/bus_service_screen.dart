import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/custom_exception.dart';
import '../../../shared/data/local_db_repository.dart';
import '../../../shared/presentation/error_display.dart';
import '../../bus_routes/presentation/bus_route_tile.dart';
import '../../bus_stops/domain/bus_stop_value_model.dart';
import '../domain/bus_service_value_model.dart';

part 'bus_service_screen.g.dart';

@riverpod
Future<BusServiceValueModel> busServiceValueModel(
  BusServiceValueModelRef ref, {
  required String serviceNo,
  required String busStopCode,
}) async {
  final repo = ref.watch(localDbRepositoryProvider);
  final busService = await repo.getBusService(
    serviceNo: serviceNo,
    busStopCode: busStopCode,
  );
  return busService[0];
}

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

class BusServiceScreen extends ConsumerWidget {
  const BusServiceScreen({
    super.key,
    required this.serviceNo,
    required this.busStopCode,
  });

  final String serviceNo;
  final String busStopCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busServiceValueModel = ref.watch(
      busServiceValueModelProvider(
        serviceNo: serviceNo,
        busStopCode: busStopCode,
      ),
    );
    final busStopValueModel = ref.watch(
      busStopValueModelProvider(
        serviceNo: serviceNo,
        busStopCode: busStopCode,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus $serviceNo Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Card(
            margin: const EdgeInsets.all(10),
            child: busServiceValueModel.when(
              data: (busService) => Padding(
                padding: const EdgeInsets.all(8),
                child: Table(
                  children: [
                    const TableRow(
                      children: [
                        Text(
                          'From:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'To:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(busService.originCode),
                        Text(busService.destinationCode),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Operator:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Category:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(busService.busOperator),
                        Text(busService.category),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Frequency',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(''),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Text('From 06:30 to 08:30:'),
                        Text('From 17:00 to 19:00:'),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text('${busService.amPeakFreq} mins'),
                        Text('${busService.pmPeakFreq} mins'),
                      ],
                    ),
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text('From 08:31 to 16:59:'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text('After 19:00:'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Text('${busService.amOffpeakFreq} mins'),
                        Text('${busService.pmOffpeakFreq} mins'),
                      ],
                    ),
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) {
                if (error is CustomException) {
                  return ErrorDisplay(
                    message: error.message,
                    onPressed: () {
                      ref.invalidate(
                        busServiceValueModelProvider(
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
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Card(
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
                          busServiceValueModelProvider(
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
            ),
          ),
        ],
      ),
    );
  }
}
