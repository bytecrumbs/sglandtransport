import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/local_storage_keys.dart';
import '../../../shared/application/local_storage_service.dart';
import '../../../shared/third_party_providers.dart';
import '../../bus_stops/data/bus_local_repository.dart';
import '../data/bus_services_repository.dart';
import '../domain/bus_arrival_model.dart';
import '../domain/bus_arrival_service_model.dart';
import '../domain/next_bus_model.dart';

final busServicesServiceProvider =
    Provider<BusServicesService>(BusServicesService.new);

class BusServicesService {
  BusServicesService(this._ref);

  final Ref _ref;

  Future<BusArrivalModel> getBusArrivals(String busStopCode) async {
    // get arrival times for bus services
    final repository = _ref.read(busServicesRepositoryProvider);
    final busArrivals =
        await repository.fetchBusArrivals(busStopCode: busStopCode);

    // add destination description to busArrivals
    final busArrivalsWithDestination =
        await _addDestination(busArrivals: busArrivals.services);

    // add services that are currently not in operation
    final busArrivalsWithDestinationAndNotInOperation =
        await _addNotInOperation(
      busArrivals: busArrivalsWithDestination,
      busStopCode: busStopCode,
    );

    // mark favorite bus service no
    final busArrivalsWithFavorites = _markFavoriteBusNo(
      busStopCode: busStopCode,
      busArrivals: busArrivalsWithDestinationAndNotInOperation,
    )..sort(
        (var a, var b) => int.parse((a.serviceNo).replaceAll(RegExp(r'\D'), ''))
            .compareTo(int.parse((b.serviceNo).replaceAll(RegExp(r'\D'), ''))),
      );

    return busArrivals.copyWith(services: busArrivalsWithFavorites);
  }

  // the BusArrival API only returns bus services that are currently in service,
  // so we need to add the bus services not currenlty in service manually by
  // looking up the BusRoutes, which we are storing in the local DB
  Future<List<BusArrivalServiceModel>> _addNotInOperation({
    required List<BusArrivalServiceModel> busArrivals,
    required String busStopCode,
  }) async {
    final busRoutes = await _ref
        .read(busLocalRepositoryProvider)
        .getBusServiceNosForBusStopCode(busStopCode);
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
        final missingBusArrivalServiceModel = BusArrivalServiceModel(
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
    return busArrivals;
  }

  List<BusArrivalServiceModel> _markFavoriteBusNo({
    required String busStopCode,
    required List<BusArrivalServiceModel> busArrivals,
  }) {
    final localStorageService = _ref.read(localStorageServiceProvider);
    return busArrivals
        .map(
          (e) => e.copyWith(
            isFavorite: localStorageService.containsValueInList(
              favoriteServiceNoKey,
              '$busStopCode$busStopCodeServiceNoDelimiter${e.serviceNo}',
            ),
          ),
        )
        .toList();
  }

  Future<List<BusArrivalServiceModel>> _addDestination({
    required List<BusArrivalServiceModel> busArrivals,
  }) async {
    // get a list of all bus service nos
    final busArrivalsDestinationCode =
        busArrivals.map((e) => e.nextBus.destinationCode ?? '').toList();

    // fetch all bus stops as per the busArrivals list
    final busStops = await _ref
        .read(busLocalRepositoryProvider)
        .getBusStops(busStopCodes: busArrivalsDestinationCode);

    // add the destination to the busArrivals list
    final busArrivalsWithDestination = <BusArrivalServiceModel>[];
    for (final busArrival in busArrivals) {
      final destination = busStops
          .where(
            (element) =>
                element.busStopCode == busArrival.nextBus.destinationCode,
          )
          .toList();
      if (destination.isNotEmpty) {
        busArrivalsWithDestination.add(
          busArrival.copyWith(
            destinationName: destination[0].description ?? '',
          ),
        );
      } else {
        busArrivalsWithDestination.add(busArrival);
      }
    }
    return busArrivalsWithDestination;
  }

  bool toggleFavoriteBusService({
    required String busStopCode,
    required String serviceNo,
  }) {
    final localStorageService = _ref.read(localStorageServiceProvider);
    final searchValue = '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo';
    bool newIsFavoriteValue;
    final currentFavorites =
        localStorageService.getStringList(favoriteServiceNoKey);

    // add or remove the service no from the local storage
    if (currentFavorites.contains(searchValue)) {
      _ref.read(loggerProvider).d(
            'removing from Favorites, as bus stop with service no already exists',
          );
      localStorageService.removeStringFromList(
        favoriteServiceNoKey,
        searchValue,
      );
      newIsFavoriteValue = false;
    } else {
      _ref
          .read(loggerProvider)
          .d('adding to Favorites, as bus stop with service no does not exist');
      localStorageService.addStringToList(favoriteServiceNoKey, searchValue);
      newIsFavoriteValue = true;
    }
    return newIsFavoriteValue;
  }

  Future<List<BusArrivalModel>> getFavoriteBusServices() async {
    // __handleLegacyFavorites is only required temporarily and can be removed
    // again in a later version, as it migrates the old bus stop favorites
    // to the new way we are storing bus services in favorites
    // maybe we can delete this code again after a few releases
    await _handleLegacyFavorites();

    final localStorageService = _ref.read(localStorageServiceProvider);
    final repository = _ref.read(busServicesRepositoryProvider);

    final currentFavorites =
        localStorageService.getStringList(favoriteServiceNoKey);

    _sortFavorites(currentFavorites);

    final rawBusArrivalModelList = <BusArrivalModel>[];

    for (final favorite in currentFavorites) {
      final busStopCode = favorite.split(busStopCodeServiceNoDelimiter)[0];
      final serviceNo = favorite.split(busStopCodeServiceNoDelimiter)[1];
      final busArrivalModel = await repository.fetchBusArrivals(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
      );

      // if the bus is not in service, the API will return an empty list, so
      // we are adding a service model marking it as "not in service"
      if (busArrivalModel.services.isEmpty) {
        rawBusArrivalModelList.add(
          busArrivalModel.copyWith(
            services: [
              BusArrivalServiceModel(
                serviceNo: serviceNo,
                busOperator: '',
                nextBus: NextBusModel(),
                nextBus2: NextBusModel(),
                nextBus3: NextBusModel(),
                inService: false,
              ),
            ],
          ),
        );
      } else {
        rawBusArrivalModelList.add(busArrivalModel);
      }
    }

    final enrichedBusArrivalModelList = <BusArrivalModel>[];
    for (final busArrivalModel in rawBusArrivalModelList) {
      final busServiceNoListWithDestination =
          await _addDestination(busArrivals: busArrivalModel.services);

      // Mark all entires as favorite bus services
      final busArrivalsWithFavorites = busServiceNoListWithDestination
          .map((e) => e.copyWith(isFavorite: true))
          .toList();

      final busStops = await _ref.read(busLocalRepositoryProvider).getBusStops(
        busStopCodes: [busArrivalModel.busStopCode],
      );

      enrichedBusArrivalModelList.add(
        busArrivalModel.copyWith(
          services: busArrivalsWithFavorites,
          roadName: busStops[0].roadName,
          description: busStops[0].description,
        ),
      );
    }

    return enrichedBusArrivalModelList;
  }

  Future<void> _handleLegacyFavorites() async {
    final localStorageService = _ref.read(localStorageServiceProvider);
    final busDatabaseService = _ref.read(busLocalRepositoryProvider);

    final favoriteBusStops =
        localStorageService.getStringList(favoriteBusStopsKey);

    if (favoriteBusStops.isNotEmpty) {
      _ref
          .read(loggerProvider)
          .d('Found favorite bus stops and processing them');
      for (final favoriteBusStop in favoriteBusStops) {
        final busStops = await busDatabaseService
            .getBusServiceNosForBusStopCode(favoriteBusStop);

        _ref.read(loggerProvider).d('Processing bus stop $favoriteBusStop');
        final existingBusServiceFavorites =
            localStorageService.getStringList(favoriteServiceNoKey);
        for (final busStop in busStops) {
          final valueToAdd =
              '${busStop.busStopCode}$busStopCodeServiceNoDelimiter${busStop.serviceNo}';

          // only add if it doesn't exist yet
          if (existingBusServiceFavorites
              .where((element) => element == valueToAdd)
              .toList()
              .isEmpty) {
            await localStorageService.addStringToList(
              favoriteServiceNoKey,
              valueToAdd,
            );
          }
        }
      }
      _ref
          .read(loggerProvider)
          .d('Removing legacy favoriteBusStop key from local storage');
      await localStorageService.remove(favoriteBusStopsKey);
    }
  }

  void _sortFavorites(List<String> list) {
// sort the list by bus stop code and then bus service no. this is done by
    // 1. splitting the string into separate fields for bus stop code and bus
    // service no
    // 2. remove the letter at the end of the bus service no, if there is one
    // 3. pad the left side with '0', so that it can be sorted alphabetically
    // example:
    // '01012~12e' -> '01012012'
    // '01012~2 -> 010112002
    list.sort((a, b) {
      final aBusStopCode = a.split(busStopCodeServiceNoDelimiter)[0];
      final bBusStopCode = b.split(busStopCodeServiceNoDelimiter)[0];
      final aBusServiceNo = a
          .split(busStopCodeServiceNoDelimiter)[1]
          .replaceAll(RegExp(r'\D'), '')
          .padLeft(3, '0');
      final bBusServiceNo = b
          .split(busStopCodeServiceNoDelimiter)[1]
          .replaceAll(RegExp(r'\D'), '')
          .padLeft(3, '0');
      final aComparison = '$aBusStopCode$aBusServiceNo';
      final bComparison = '$bBusStopCode$bBusServiceNo';
      return aComparison.compareTo(bComparison);
    });
  }

  bool isFavorite({
    required String busStopCode,
    required String serviceNo,
  }) {
    final localStorageService = _ref.read(localStorageServiceProvider);
    final searchValue = '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo';

    final currentFavorites =
        localStorageService.getStringList(favoriteServiceNoKey);

    return currentFavorites.contains(searchValue);
  }
}