import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/common_providers.dart';
import '../../shared/constants.dart';
import '../../shared/services/local_storage_service.dart';
import '../bus_database_service.dart';
import '../bus_repository.dart';

final busStopListFavoritesViewModelStateProvider =
    StateNotifierProvider.autoDispose<BusStopListFavoritesViewModel,
        AsyncValue<List<BusArrivalServicesModel>>>(
  (ref) => BusStopListFavoritesViewModel(ref.read),
);

class BusStopListFavoritesViewModel
    extends StateNotifier<AsyncValue<List<BusArrivalServicesModel>>> {
  BusStopListFavoritesViewModel(this._read)
      : super(const AsyncValue.loading()) {
    init();
  }

  final Reader _read;

  late final Timer _timer;

  Future<void> init() async {
    state = AsyncValue.data(await getFavoriteBusServices());
    _read(loggerProvider).d('starting timer for favorite bus arrival refresh');
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
    _read(loggerProvider).d('cancelled timer for favorite bus arrival refresh');
    super.dispose();
  }

  Future<List<BusArrivalServicesModel>> getFavoriteBusServices() async {
    final localStorageService = _read(localStorageServiceProvider);
    final currentFavorites =
        localStorageService.getStringList(favoriteServiceNoKey);
    final repository = _read(busRepositoryProvider);

    final busServices = <BusArrivalServicesModel>[];

    for (final favorite in currentFavorites) {
      final busStopCode = favorite.split(busStopCodeServiceNoDelimiter)[0];
      final serviceNo = favorite.split(busStopCodeServiceNoDelimiter)[1];
      final busArrivalServicesModelList = await repository.fetchBusArrivals(
        busStopCode: busStopCode,
        serviceNo: serviceNo,
      );

      // if the bus is not in service, the API will return an empty list
      if (busArrivalServicesModelList.isEmpty) {
        busServices.add(
          BusArrivalServicesModel(
            serviceNo: serviceNo,
            busOperator: '',
            nextBus: NextBusModel(),
            nextBus2: NextBusModel(),
            nextBus3: NextBusModel(),
            inService: false,
          ),
        );
      } else {
        busServices.add(busArrivalServicesModelList[0]);
      }
    }

    // as [fetchBusArrivals] returns a list, but that list will only have 1
    // entry because we are fetching based on bus service no, we have to remove
    // the inner list.
    // final busServiceNoList = futures.map((e) => e[0]).toList();

    final busServiceNoListWithDestination =
        await _addDestination(busArrivals: busServices);

    // Mark all entires as favorite bus services
    final busArrivalsWithFavorites = busServiceNoListWithDestination
        .map((e) => e.copyWith(isFavorite: true))
        .toList();

    return busArrivalsWithFavorites;
  }

  // TODO: This is an exact duplicate of the same method in [BusStopPageViewModel] and needs to be refactored!
  // I am not sure at this point how to make it reusable! :-(
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
}
