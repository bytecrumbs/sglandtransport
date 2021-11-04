import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/constants.dart';
import '../../shared/services/local_storage_service.dart';
import '../bus_database_service.dart';
import '../bus_repository.dart';

final busStopListFavoritesViewModelProvider =
    Provider((ref) => BusStopListFavoritesViewModel(ref.read));

class BusStopListFavoritesViewModel {
  BusStopListFavoritesViewModel(this.read);

  final Reader read;

  Future<List<BusStopValueModel>> getFavoriteBusStops() async {
    final localStorageService = read(localStorageServiceProvider);
    final currentFavorites =
        localStorageService.getStringList(favoriteBusStopsKey);
    final busDbService = read(busDatabaseServiceProvider);
    final tableBusStopList = await busDbService.getBusStops(
      favoriteBusStops: currentFavorites,
    );
    final busStopValueModelList = tableBusStopList
        .map((e) => BusStopValueModel(
              busStopCode: e.busStopCode,
              description: e.description,
              roadName: e.roadName,
              latitude: e.latitude,
              longitude: e.longitude,
            ))
        .toList();
    return busStopValueModelList;
  }
}
