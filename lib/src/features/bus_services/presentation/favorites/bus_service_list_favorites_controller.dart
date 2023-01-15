import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/bus_arrival_config.dart';
import '../../../../constants/local_storage_keys.dart';
import '../../../../shared/application/local_storage_service.dart';
import '../../../../shared/third_party_providers.dart';
import '../../../bus_stops/application/bus_database_service.dart';
import '../../data/bus_services_repository.dart';
import '../../domain/bus_arrival_model.dart';
import '../../domain/bus_arrival_service_model.dart';
import '../../domain/next_bus_model.dart';

final busServiceListFavoritesControllerStateProvider =
    StateNotifierProvider.autoDispose<BusServiceListFavoritesController,
        AsyncValue<List<BusArrivalModel>>>(
  BusServiceListFavoritesController.new,
);

class BusServiceListFavoritesController
    extends StateNotifier<AsyncValue<List<BusArrivalModel>>> {
  BusServiceListFavoritesController(this._ref)
      : super(const AsyncValue.loading()) {
    init();
  }

  final Ref _ref;

  late final Timer _timer;

  Future<void> init() async {
    state = AsyncValue.data(await getFavoriteBusServices());
    _ref
        .read(loggerProvider)
        .d('starting timer for favorite bus arrival refresh');
    _timer = Timer.periodic(
      busArrivalRefreshDuration,
      (_) async {
        state = AsyncValue.data(await getFavoriteBusServices());
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _ref
        .read(loggerProvider)
        .d('cancelled timer for favorite bus arrival refresh');
    super.dispose();
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

      final busStops = await _ref.read(busDatabaseServiceProvider).getBusStops(
        favoriteBusStops: [busArrivalModel.busStopCode],
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
    final busDatabaseService = _ref.read(busDatabaseServiceProvider);

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

  // TODO: This is an exact duplicate of the same method in [BusStopPageViewModel] and needs to be refactored!
  // I am not sure at this point how to make it reusable! :-(
  Future<List<BusArrivalServiceModel>> _addDestination({
    required List<BusArrivalServiceModel> busArrivals,
  }) async {
    // get a list of all bus service nos
    final busArrivalsDestinationCode =
        busArrivals.map((e) => e.nextBus.destinationCode ?? '').toList();

    // fetch all bus stops as per the busArrivals list
    final busStops = await _ref
        .read(busDatabaseServiceProvider)
        .getBusStops(favoriteBusStops: busArrivalsDestinationCode);

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

  Future<void> toggleFavoriteBusService({
    required String busStopCode,
    required String serviceNo,
  }) async {
    final localStorageService = _ref.read(localStorageServiceProvider);
    final searchValue = '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo';

    // add or remove the service no from the local storage
    if (isFavorite(busStopCode: busStopCode, serviceNo: serviceNo)) {
      _ref.read(loggerProvider).d(
            'removing from Favorites, as bus stop with service no already exists',
          );
      await localStorageService.removeStringFromList(
        favoriteServiceNoKey,
        searchValue,
      );
    } else {
      _ref
          .read(loggerProvider)
          .d('adding to Favorites, as bus stop with service no does not exist');
      await localStorageService.addStringToList(
        favoriteServiceNoKey,
        searchValue,
      );
    }

    state = AsyncValue.data(await getFavoriteBusServices());
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
