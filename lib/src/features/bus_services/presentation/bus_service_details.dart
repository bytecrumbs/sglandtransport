import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/custom_exception.dart';
import '../../../shared/data/local_db_repository.dart';
import '../../../shared/presentation/error_display.dart';
import '../domain/bus_service_value_model.dart';

part 'bus_service_details.g.dart';

@riverpod
Future<BusServiceValueModel> busServiceValueModel(
  BusServiceValueModelRef ref, {
  required String serviceNo,
  required String destinationCode,
}) async {
  final repo = ref.watch(localDbRepositoryProvider);
  final busService = await repo.getBusService(
    serviceNo: serviceNo,
    destinationCode: destinationCode,
  );
  return busService[0];
}

class BusServiceDetails extends ConsumerWidget {
  const BusServiceDetails({
    super.key,
    required this.destinationCode,
    required this.serviceNo,
  });

  final String serviceNo;
  final String destinationCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busServiceValueModel = ref.watch(
      busServiceValueModelProvider(
        serviceNo: serviceNo,
        destinationCode: destinationCode,
      ),
    );
    return Card(
      margin: const EdgeInsets.all(10),
      child: busServiceValueModel.when(
        data: (busService) => Padding(
          padding: const EdgeInsets.all(8),
          child: Table(
            children: [
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
