import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/bus_arrival_config.dart';
import '../../../../constants/local_storage_keys.dart';
import '../../../../shared/application/local_storage_service.dart';
import '../../../../shared/third_party_providers.dart';
import '../../../bus_stops/data/bus_local_repository.dart';
import '../../application/bus_services_utility_service.dart';
import '../../data/bus_services_repository.dart';
import '../../domain/bus_arrival_model.dart';
import '../../domain/bus_arrival_service_model.dart';
import '../../domain/next_bus_model.dart';

final busServicesListScreenControllerStateNotifierProvider =
    StateNotifierProvider.autoDispose.family<BusServicesListScreenController,
        AsyncValue<BusArrivalModel>, String>(
  BusServicesListScreenController.new,
);

class BusServicesListScreenController
    extends StateNotifier<AsyncValue<BusArrivalModel>> {
  BusServicesListScreenController(this._ref, this._busStopCode)
      : super(const AsyncValue.loading()) {
    init();
  }

  final Ref _ref;
  final String _busStopCode;

  late final Timer _timer;

  Future<void> init({bool isRefreshing = false}) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      state = AsyncValue.data(await getBusArrivals(_busStopCode));
      _ref.read(loggerProvider).d('starting timer for bus arrival refresh');
      _timer = Timer.periodic(
        busArrivalRefreshDuration,
        (_) async {
          state = AsyncValue.data(await getBusArrivals(_busStopCode));
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _ref.read(loggerProvider).d('cancelled timer for bus arrival refresh');
    super.dispose();
  }

  Future<BusArrivalModel> getBusArrivals(String busStopCode) async {
    // get arrival times for bus services
    final repository = _ref.read(busServicesRepositoryProvider);
    final busArrivals =
        await repository.fetchBusArrivals(busStopCode: busStopCode);

    // add destination description to busArrivals
    final busArrivalsWithDestination = await _ref
        .read(busServicesUtilityServiceProvider)
        .addDestination(busArrivals: busArrivals.services);

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

  /// the BusArrival API only returns bus services that are currently in service,
  /// so we need to add the bus services not currenlty in service manually by
  /// looking up the BusRoutes, which we are storing in the local DB
  Future<List<BusArrivalServiceModel>> _addNotInOperation({
    required List<BusArrivalServiceModel> busArrivals,
    required String busStopCode,
  }) async {
    final busRoutes = await _ref
        .read(busDatabaseServiceProvider)
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

  void toggleFavoriteBusService({
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

    // update the state with the new favorite value
    final resultToUpdate = state.asData!.value;
    final listToUpate = resultToUpdate.services;
    final indexToUpate =
        listToUpate.indexWhere((element) => element.serviceNo == serviceNo);
    listToUpate[indexToUpate] =
        listToUpate[indexToUpate].copyWith(isFavorite: newIsFavoriteValue);
    state = AsyncValue.data(resultToUpdate.copyWith(services: listToUpate));
  }
}
