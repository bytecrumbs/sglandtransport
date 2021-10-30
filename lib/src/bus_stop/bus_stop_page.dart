import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lta_datamall_flutter/src/bus_stop/bus_database_service.dart';
import 'package:lta_datamall_flutter/src/bus_stop/widgets/bus_arrival_card.dart';
import 'package:lta_datamall_flutter/src/shared/common_providers.dart';

import '../shared/custom_exception.dart';
import '../shared/error_display.dart';

import 'bus_repository.dart';

final busArrivalFutureProvider = FutureProvider.family
    .autoDispose<List<BusArrivalServicesModel>, String>(
        (ref, busStopCode) async {
  final repository = ref.watch(busRepositoryProvider);
  final db = ref.watch(busDatabaseServiceProvider);
  final busRoutes = await db.allBusRouteEntries;
  ref.watch(loggerProvider).d(busRoutes.length);
  return repository.fetchBusArrivals(busStopCode);
});

class BusStopPage extends ConsumerWidget {
  const BusStopPage({Key? key, required this.busStopCode}) : super(key: key);

  static const routeName = '/busStop';

  final String busStopCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busArrival = ref.watch(busArrivalFutureProvider(busStopCode));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrival'),
      ),
      body: busArrival.when(
        data: (busArrival) => ListView.builder(
          itemCount: busArrival.length,
          itemBuilder: (_, index) => BusArrivalCard(
            busArrivalModel: busArrival[index],
          ),
        ),
        loading: (_) => const Center(child: CircularProgressIndicator()),
        error: (error, stack, _) {
          if (error is CustomException) {
            return ErrorDisplay(message: error.message);
          }
          return ErrorDisplay(
            message: error.toString(),
          );
        },
      ),
    );
  }
}
