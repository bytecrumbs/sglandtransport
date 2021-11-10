import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../bus_database_service.dart';
import '../bus_repository.dart';

final busStopListNearbyViewModelProvider =
    Provider((ref) => BusStopListNearbyViewModel(ref.read));

class BusStopListNearbyViewModel {
  BusStopListNearbyViewModel(this.read);

  final Reader read;

  Future<List<BusStopValueModel>> getNearbyBusStops({
    required double latitude,
    required double longitude,
  }) async {
    final busDbService = read(busDatabaseServiceProvider);

    // fetch all bus stops from the database and then filter based on the cached
    // result. This is more efficient than querying the local database with a filter
    // every time the location changes, I think... :-)
    final allBusStops = await busDbService.getBusStops();

    return busDbService.filterNearbyBusStops(
      currentLatitude: latitude,
      currentLongitude: longitude,
      busStopList: allBusStops,
    );
  }
}
