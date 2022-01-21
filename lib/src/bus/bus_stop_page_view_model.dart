import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/common_providers.dart';
import '../shared/constants.dart';
import '../shared/services/local_storage_service.dart';
import 'bus_database_service.dart';
import 'bus_repository.dart';

final busStopPageViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose.family<BusStopPageViewModel,
        AsyncValue<List<BusArrivalServicesModel>>, String>(
  (ref, busStopCode) => BusStopPageViewModel(ref.read, busStopCode),
);

class BusStopPageViewModel
    extends StateNotifier<AsyncValue<List<BusArrivalServicesModel>>> {
  BusStopPageViewModel(this._read, this._busStopCode)
      : super(const AsyncValue.loading()) {
    init();
  }

  final Reader _read;
  final String _busStopCode;

  late final Timer _timer;

  Future<void> init() async {
    state = AsyncValue.data(await getBusArrivals(_busStopCode));
    _read(loggerProvider).d('starting timer for bus arrival refresh');
    _timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) async {
        state = AsyncValue.data(await getBusArrivals(_busStopCode));
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _read(loggerProvider).d('cancelled timer for bus arrival refresh');
    super.dispose();
  }

  bool isFavoriteBusStop(String busStopCode) {
    final localStorageService = _read(localStorageServiceProvider);
    return localStorageService.containsValueInList(
        favoriteBusStopsKey, busStopCode);
  }

  Future<List<BusArrivalServicesModel>> getBusArrivals(
      String busStopCode) async {
    // get arrival times for bus services
    final repository = _read(busRepositoryProvider);
    final busArrivals = await repository.fetchBusArrivals(busStopCode);

    // add destination description to busArrivals
    final busArrivalsWithDestination =
        await _addDestination(busArrivals: busArrivals);

    // add services that are currently not in operation
    final busArrivalsWithDestinationAndNotInOperation =
        await _addNotInOperation(
      busArrivals: busArrivalsWithDestination,
      busStopCode: busStopCode,
    );

    // sort result
    busArrivalsWithDestinationAndNotInOperation.sort((var a, var b) =>
        int.parse((a.serviceNo).replaceAll(RegExp(r'\D'), ''))
            .compareTo(int.parse((b.serviceNo).replaceAll(RegExp(r'\D'), ''))));

    return busArrivalsWithDestinationAndNotInOperation;
  }

  Future<List<BusArrivalServicesModel>> _addDestination(
      {required List<BusArrivalServicesModel> busArrivals}) async {
    // get a list of all bus service nos
    final busArrivalsDestinationCode =
        busArrivals.map((e) => e.nextBus.destinationCode ?? '').toList();

    // fetch all bus stops as per the busArrivals list
    final busStops = await _read(busDatabaseServiceProvider)
        .getBusStops(favoriteBusStops: busArrivalsDestinationCode);

    // add the destination to the busArrivals list
    final busArrivalsWithDestination = <BusArrivalServicesModel>[];
    for (final busArrival in busArrivals) {
      final destination = busStops
          .where((element) =>
              element.busStopCode == busArrival.nextBus.destinationCode)
          .toList();
      if (destination.isNotEmpty) {
        busArrivalsWithDestination.add(busArrival.copyWith(
            destinationName: destination[0].description ?? ''));
      } else {
        busArrivalsWithDestination.add(busArrival);
      }
    }
    return busArrivalsWithDestination;
  }

  /// the BusArrival API only returns bus services that are currently in service,
  /// so we need to add the bus services not currenlty in service manually by
  /// looking up the BusRoutes, which we are storing in the local DB
  Future<List<BusArrivalServicesModel>> _addNotInOperation({
    required List<BusArrivalServicesModel> busArrivals,
    required String busStopCode,
  }) async {
    final busRoutes = await _read(busDatabaseServiceProvider)
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
    return busArrivals;
  }

  void toggleFavoriteBusStop(String busStopCode) {
    final localStorageService = _read(localStorageServiceProvider);
    final currentFavorites =
        localStorageService.getStringList(favoriteBusStopsKey);
    if (currentFavorites.contains(busStopCode)) {
      _read(loggerProvider)
          .d('removing from Favorites, as bus stop already exists');
      localStorageService.removeStringFromList(
          favoriteBusStopsKey, busStopCode);
    } else {
      _read(loggerProvider)
          .d('adding to Favorites, as bus stop does not exist');
      localStorageService.addStringToList(favoriteBusStopsKey, busStopCode);
    }
  }
}
