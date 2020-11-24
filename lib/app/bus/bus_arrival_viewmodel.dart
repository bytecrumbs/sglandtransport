import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import '../../constants.dart';
import '../../services/api.dart';
import '../../services/local_storage_service.dart';
import 'models/bus_arrival_service_model.dart';

/// Provides the BusArrivalViewModel class
final busArrivalViewModelProvider =
    Provider((ref) => BusArrivalViewModel(ref.read));

/// The viewmodel for the BusArrival screen
class BusArrivalViewModel {
  static final _log = Logger('BusArrivalViewModel');

  /// a reader that enables reading other providers
  final Reader read;

  /// constructor for the model
  BusArrivalViewModel(this.read);

  /// returns bus arrival services, sorted by bus number
  Future<List<BusArrivalServiceModel>> getBusArrivalServiceList(
      String busStopCode) async {
    final _api = read(apiProvider);
    var busArrivalList = await _api.fetchBusArrivalList(busStopCode);

    busArrivalList.sort((var a, var b) =>
        int.parse(a.serviceNo.replaceAll(RegExp('\\D'), ''))
            .compareTo(int.parse(b.serviceNo.replaceAll(RegExp('\\D'), ''))));

    return busArrivalList;
  }

  /// adds or removes a bus stop code from the stored favorites, depending
  /// on whether it already exists or is a new bus stop
  Future<List<String>> toggleFavoriteBusStop(String busStopCode) async {
    _log.info('toggling $busStopCode on Favorites');
    final localStorageService = read(localStorageServiceProvider);
    var currentFavorites =
        await localStorageService.getStringList(Constants.favoriteBusStopsKey);
    if (currentFavorites.contains(busStopCode)) {
      _log.info('removing from Favorites, as bus stop already exists');
      await localStorageService.removeStringFromList(
          Constants.favoriteBusStopsKey, busStopCode);
      currentFavorites.remove(busStopCode);
    } else {
      _log.info('adding to Favorites, as bus stop does not exist');
      await localStorageService.addStringToList(
          Constants.favoriteBusStopsKey, busStopCode);
      currentFavorites.add(busStopCode);
    }
    return currentFavorites;
  }

  /// checks if a bus stop is a favorite bus stop
  Future<bool> isFavoriteBusStop(String busStopCode) async {
    final localStorageService = read(localStorageServiceProvider);
    return await localStorageService.containsValueInList(
        Constants.favoriteBusStopsKey, busStopCode);
  }
}
