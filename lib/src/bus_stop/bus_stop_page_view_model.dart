import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/constants.dart';
import '../shared/services/local_storage_service.dart';
import 'bus_database_service.dart';
import 'bus_repository.dart';

final busStopPageViewModelProvider =
    Provider((ref) => BusStopPageViewModel(ref.read));

class BusStopPageViewModel {
  BusStopPageViewModel(this.read);

  final Reader read;

  bool isFavoriteBusStop(String busStopCode) {
    final localStorageService = read(localStorageServiceProvider);
    return localStorageService.containsValueInList(
        favoriteBusStopsKey, busStopCode);
  }

  Future<List<BusArrivalServicesModel>> getBusArrivals(
      String busStopCode) async {
    // fetch info from API and local DB
    final repository = read(busRepositoryProvider);
    final db = read(busDatabaseServiceProvider);
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
  }
}
