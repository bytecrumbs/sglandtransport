import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import '../../constants.dart';
import '../../services/api.dart';
import '../../services/database_service.dart';
import '../../services/local_storage_service.dart';
import 'models/bus_arrival_service_model.dart';
import 'models/next_bus_model.dart';

/// Provides the BusArrivalViewModel class
final busArrivalViewModelProvider =
    Provider((ref) => BusArrivalViewModel(ref.read));

/// The viewmodel for the BusArrival screen
class BusArrivalViewModel {
  /// constructor for the model
  BusArrivalViewModel(this.read);

  /// a reader that enables reading other providers
  final Reader read;

  static final _log = Logger('BusArrivalViewModel');

  /// returns bus arrival services, sorted by bus number
  Future<List<BusArrivalServiceModel>> getBusArrivalServiceList(
      String busStopCode) async {
    final _api = read(apiProvider);
    final _databaseService = read(databaseServiceProvider);
    final busArrivalList = await _api.fetchBusArrivalList(busStopCode);
    final busServicesFromApi = busArrivalList;

    _log.info('getting all bus services for $busStopCode from bus routes DB');
    final busServicesFromBusRoutes =
        await _databaseService.getBusRoutes(busStopCode);

    final newBusArrivalServiceListModel = <BusArrivalServiceModel>[];

    for (final item in busServicesFromApi) {
      final busStop = await _databaseService
          .getBusStops([item.nextBus.destinationCode ?? '']);
      final busService = item.copyWith(destinationName: busStop[0].description);
      newBusArrivalServiceListModel.add(busService);
    }

    // add services not in use to the original api result
    if (newBusArrivalServiceListModel.length <
        busServicesFromBusRoutes.length) {
      final busServicesFromApiList =
          newBusArrivalServiceListModel.map((e) => e.serviceNo).toList();
      final busServicesFromBusRoutesList =
          busServicesFromBusRoutes.map((e) => e.serviceNo).toList();

      final busNoDifferences = busServicesFromBusRoutesList
          .toSet()
          .difference(busServicesFromApiList.toSet())
          .toList();

      // busNoDifferences.forEach((element) {
      for (final element in busNoDifferences) {
        final missingBusArrivalServiceModel = BusArrivalServiceModel(
          serviceNo: element,
          busOperator: '',
          inService: false,
          nextBus: NextBusModel(),
          nextBus2: NextBusModel(),
          nextBus3: NextBusModel(),
        );
        newBusArrivalServiceListModel.add(missingBusArrivalServiceModel);
      }
    }

    newBusArrivalServiceListModel.sort((var a, var b) =>
        int.parse((a.serviceNo).replaceAll(RegExp(r'\D'), ''))
            .compareTo(int.parse((b.serviceNo).replaceAll(RegExp(r'\D'), ''))));

    return newBusArrivalServiceListModel;
  }

  /// adds or removes a bus stop code from the stored favorites, depending
  /// on whether it already exists or is a new bus stop
  Future<List<String>> toggleFavoriteBusStop(String busStopCode) async {
    _log.info('toggling $busStopCode on Favorites');
    final localStorageService = read(localStorageServiceProvider);
    final currentFavorites =
        localStorageService.getStringList(Constants.favoriteBusStopsKey);
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
  bool isFavoriteBusStop(String busStopCode) {
    final localStorageService = read(localStorageServiceProvider);
    return localStorageService.containsValueInList(
        Constants.favoriteBusStopsKey, busStopCode);
  }
}
