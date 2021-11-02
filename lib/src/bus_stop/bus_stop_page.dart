import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/constants.dart';
import '../shared/custom_exception.dart';
import '../shared/services/local_storage_service.dart';
import '../shared/widgets/error_display.dart';
import 'bus_database_service.dart';
import 'bus_repository.dart';
import 'widgets/bus_arrival_card.dart';

// checks if a given bus stop is a favorite bus stop
final isFavoriteBusStopStateProvider =
    StateProvider.autoDispose.family<bool, String>((ref, busStopCode) {
  final localStorageService = ref.watch(localStorageServiceProvider);
  return localStorageService.containsValueInList(
      favoriteBusStopsKey, busStopCode);
});

final busArrivalsFutureProvider = FutureProvider.family
    .autoDispose<List<BusArrivalServicesModel>, String>(
        (ref, busStopCode) async {
  // fetch info from API and local DB
  final repository = ref.watch(busRepositoryProvider);
  final db = ref.watch(busDatabaseServiceProvider);
  final busRoutes = await db.getBusServiceNosForBusStopCode(busStopCode);
  final busArrivals = await repository.fetchBusArrivals(busStopCode);

  // the BusArrival API only returns bus services that are currently in service,
  // so we need to add the bus services not currenlty in service manually by
  // looking up the BusRoutes, which we are storing in the local DB
  if (busRoutes.length > busArrivals.length) {
    // create a list of service numbers, so we can better compare
    final busRoutesServiceNo = busRoutes.map((e) => e.serviceNo).toList();
    final busArrivalsServiceNo = busArrivals.map((e) => e.serviceNo).toList();

    // get the difference into a list
    final serviceNoDifferences = busRoutesServiceNo
        .toSet()
        .difference(busArrivalsServiceNo.toSet())
        .toList();
    // create new elements for the bus services not in service right now
    for (final element in serviceNoDifferences) {
      final missingBusArrivalServiceModel = BusArrivalServicesModel(
        serviceNo: element ?? '',
        busOperator: '',
        inService: false,
        nextBus: NextBusModel(),
        nextBus2: NextBusModel(),
        nextBus3: NextBusModel(),
      );
      busArrivals.add(missingBusArrivalServiceModel);
    }
  }

  // sort result
  busArrivals.sort((var a, var b) =>
      int.parse((a.serviceNo).replaceAll(RegExp(r'\D'), ''))
          .compareTo(int.parse((b.serviceNo).replaceAll(RegExp(r'\D'), ''))));

  return busArrivals;
});

class BusStopPage extends ConsumerWidget {
  const BusStopPage({
    Key? key,
    required this.busStopCode,
    required this.description,
  }) : super(key: key);

  static const routeName = '/busStop';

  final String busStopCode;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busArrival = ref.watch(busArrivalsFutureProvider(busStopCode));
    final isFavoriteBusStop =
        ref.watch(isFavoriteBusStopStateProvider(busStopCode));

    return Scaffold(
      appBar: AppBar(
        title: Text(description),
        actions: [
          IconButton(
            onPressed: () {},
            icon: isFavoriteBusStop.state
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_outline),
          ),
        ],
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
