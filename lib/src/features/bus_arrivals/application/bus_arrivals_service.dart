import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../local_storage/local_storage_keys.dart';
import '../../../local_storage/local_storage_service.dart';
import '../../../third_party_providers/third_party_providers.dart';
import '../../../user_location/location_service.dart';
import '../../bus_routes/data/bus_routes_repository.dart';
import '../../bus_stops/data/bus_stops_repository.dart';
import '../../bus_stops/domain/bus_stop_value_model.dart';
import '../data/bus_arrivals_repository.dart';
import '../domain/bus_arrival_model.dart';
import '../domain/bus_arrival_service_model.dart';
import '../domain/bus_arrival_with_bus_stop_model.dart';
import '../domain/next_bus_model.dart';

part 'bus_arrivals_service.g.dart';

@Riverpod(keepAlive: true)
BusArrivalsService busArrivalsService(BusArrivalsServiceRef ref) =>
    BusArrivalsService(ref);

class BusArrivalsService {
  BusArrivalsService(this.ref);

  final Ref ref;

  Future<BusStopValueModel> getBusStop(String busStopCode) async {
    final repository = ref.read(busStopsRepositoryProvider);
    final result = await repository.getBusStops(busStopCodes: [busStopCode]);
    return result[0];
  }

  Future<BusArrivalServiceModel> getBusArrival({
    required String busStopCode,
    required String serviceNo,
  }) async {
    final busArrivalModel = await getBusArrivals(busStopCode, serviceNo);
    return busArrivalModel.services[0];
  }

  Future<BusArrivalModel> getBusArrivals(
    String busStopCode, [
    String? serviceNo,
  ]) async {
    // get arrival times for bus services
    final repository = ref.read(busArrivalsRepositoryProvider);
    final busArrivals = await repository.fetchBusArrivals(
      busStopCode: busStopCode,
      serviceNo: serviceNo,
    );

    // add services that are currently not in operation
    final servicesNotInOperation = await _servicesNotInOperation(
      busArrivals: busArrivals.services,
      busStopCode: busStopCode,
      serviceNo: serviceNo,
    );

    final allBusArrivals = [...busArrivals.services, ...servicesNotInOperation];

    // add destination description to busArrivals
    final busArrivalsWithDestinationAndNotInOperation =
        await _addDestination(busArrivals: allBusArrivals);

    // mark favorite bus service no
    final busArrivalsWithFavorites = await _markFavoriteBusNo(
      busStopCode: busStopCode,
      busArrivals: busArrivalsWithDestinationAndNotInOperation,
    )
      ..sort(
        (var a, var b) => int.parse((a.serviceNo).replaceAll(RegExp(r'\D'), ''))
            .compareTo(int.parse((b.serviceNo).replaceAll(RegExp(r'\D'), ''))),
      );

    return busArrivals.copyWith(services: busArrivalsWithFavorites);
  }

  // the BusArrival API only returns bus services that are currently in service,
  // so we need to add the bus services not currenlty in service manually by
  // looking up the BusRoutes, which we are storing in the local DB
  Future<List<BusArrivalServiceModel>> _servicesNotInOperation({
    required List<BusArrivalServiceModel> busArrivals,
    required String busStopCode,
    String? serviceNo,
  }) async {
    final busRoutes = await ref
        .read(busRoutesRepositoryProvider)
        .getBusServicesForBusStopCode(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        );
    if (busRoutes.length > busArrivals.length) {
      // create a list of service numbers, so we can better compare
      final busRoutesServiceNo = busRoutes.map((e) => e.serviceNo).toList();
      final busArrivalsServiceNo = busArrivals.map((e) => e.serviceNo).toList();

      // get the difference into a list
      final serviceNoDifferences = busRoutesServiceNo
          .toSet()
          .difference(busArrivalsServiceNo.toSet())
          .toList();

      return serviceNoDifferences
          .map(
            (e) => BusArrivalServiceModel(
              serviceNo: e,
              busOperator: '',
              inService: false,
              nextBus: NextBusModel(),
              nextBus2: NextBusModel(),
              nextBus3: NextBusModel(),
            ),
          )
          .toList();
    } else {
      return [];
    }
  }

  Future<List<BusArrivalServiceModel>> _markFavoriteBusNo({
    required String busStopCode,
    required List<BusArrivalServiceModel> busArrivals,
  }) async {
    final localStorageService = ref.read(localStorageServiceProvider);
    return Future.wait(
      busArrivals.map((e) async {
        final isFav = await localStorageService.containsValueInList(
          favoriteServiceNoKey,
          '$busStopCode$busStopCodeServiceNoDelimiter${e.serviceNo}',
        );
        return e.copyWith(
          isFavorite: isFav,
        );
      }).toList(),
    );
  }

  Future<List<BusArrivalServiceModel>> _addDestination({
    required List<BusArrivalServiceModel> busArrivals,
  }) async {
    // get a list of all bus service nos
    final busArrivalsDestinationCode =
        busArrivals.map((e) => e.nextBus.destinationCode ?? '').toList();

    // fetch all bus stops as per the busArrivals list
    final busStops = await ref
        .read(busStopsRepositoryProvider)
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
            destinationName: destination[0].description,
          ),
        );
      } else {
        busArrivalsWithDestination.add(busArrival);
      }
    }
    return busArrivalsWithDestination;
  }

  Future<bool> toggleFavoriteBusService({
    required String busStopCode,
    required String serviceNo,
  }) async {
    final localStorageService = ref.read(localStorageServiceProvider);
    final searchValue = '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo';
    bool newIsFavoriteValue;
    final currentFavorites =
        await localStorageService.getStringList(favoriteServiceNoKey);

    // add or remove the service no from the local storage
    if (currentFavorites.contains(searchValue)) {
      ref.read(loggerProvider).d(
            'removing from Favorites, as bus stop with service no already exists',
          );
      await localStorageService.removeStringFromList(
        favoriteServiceNoKey,
        searchValue,
      );
      newIsFavoriteValue = false;
    } else {
      ref
          .read(loggerProvider)
          .d('adding to Favorites, as bus stop with service no does not exist');
      await localStorageService.addStringToList(
        favoriteServiceNoKey,
        searchValue,
      );
      newIsFavoriteValue = true;
    }
    return newIsFavoriteValue;
  }

  Future<List<BusArrivalWithBusStopModel>> getFavoriteBusServices() async {
    // __handleLegacyFavorites is only required temporarily and can be removed
    // again in a later version, as it migrates the old bus stop favorites
    // to the new way we are storing bus services in favorites
    // maybe we can delete this code again after a few releases
    await _handleLegacyFavorites();

    final localStorageService = ref.read(localStorageServiceProvider);
    final repository = ref.read(busArrivalsRepositoryProvider);

    final currentFavorites =
        await localStorageService.getStringList(favoriteServiceNoKey);

    _sortFavorites(currentFavorites);

    final uniqueBusStopsList = List<String>.from(currentFavorites)
        .map((e) => e.split(busStopCodeServiceNoDelimiter)[0])
        .toSet()
        .toList();

    final busStops = await ref.read(busStopsRepositoryProvider).getBusStops(
          busStopCodes: uniqueBusStopsList,
        );

    final busArrivalWithBusStopModelList = <BusArrivalWithBusStopModel>[];

    for (final busStop in busStops) {
      // find favorites from the same bus stop
      final busServicesForBusStop = currentFavorites
          .where(
            (element) =>
                busStop.busStopCode ==
                element.split(busStopCodeServiceNoDelimiter)[0],
          )
          .toList();

      // fetch services from current bus stop
      final busArrivalServiceModelList = <BusArrivalServiceModel>[];
      for (final busService in busServicesForBusStop) {
        final busStopCode = busService.split(busStopCodeServiceNoDelimiter)[0];
        final serviceNo = busService.split(busStopCodeServiceNoDelimiter)[1];
        final busArrivalModel = await repository.fetchBusArrivals(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        );

        final busArrivalServiceModelListWithDestination =
            await _addDestination(busArrivals: busArrivalModel.services);

        // if the bus is not in service, the API will return an empty list, so
        // we are adding a service model marking it as "not in service"
        if (busArrivalModel.services.isEmpty) {
          busArrivalServiceModelList.add(
            BusArrivalServiceModel(
              serviceNo: serviceNo,
              busOperator: '',
              nextBus: NextBusModel(),
              nextBus2: NextBusModel(),
              nextBus3: NextBusModel(),
              inService: false,
              isFavorite: true,
            ),
          );
        } else {
          busArrivalServiceModelList.add(
            busArrivalServiceModelListWithDestination[0]
                .copyWith(isFavorite: true),
          );
        }
      }

      // calculate distance
      final locationService = ref.read(locationServiceProvider);
      UserLocationModel? userLocationModel;
      userLocationModel = await locationService.getCurrentPosition();
      double? distanceInMeters;

      if (userLocationModel.latitude != null &&
          userLocationModel.longitude != null) {
        distanceInMeters = locationService.getDistanceInMeters(
          startLatitude: userLocationModel.latitude!,
          startLongitude: userLocationModel.longitude!,
          endLatitude: busStop.latitude,
          endLongitude: busStop.longitude,
        );
      }
      final busStopValueModel = BusStopValueModel(
        busStopCode: busStop.busStopCode,
        description: busStop.description,
        roadName: busStop.roadName,
        latitude: busStop.latitude,
        longitude: busStop.longitude,
        distanceInMeters: distanceInMeters?.round(),
      );

      final busArrivalWithBusStopModel = BusArrivalWithBusStopModel(
        busStopValueModel: busStopValueModel,
        services: busArrivalServiceModelList,
      );

      busArrivalWithBusStopModelList.add(busArrivalWithBusStopModel);
    }

    // sort list by distance
    busArrivalWithBusStopModelList.sort((a, b) {
      final aValue = a.busStopValueModel.distanceInMeters ?? 0;
      final bValue = b.busStopValueModel.distanceInMeters ?? 0;
      return aValue.compareTo(bValue);
    });

    return busArrivalWithBusStopModelList;
  }

  Future<void> _handleLegacyFavorites() async {
    final localStorageService = ref.read(localStorageServiceProvider);
    final busRouteRepo = ref.read(busRoutesRepositoryProvider);

    final favoriteBusStops =
        await localStorageService.getStringList(favoriteBusStopsKey);

    if (favoriteBusStops.isNotEmpty) {
      ref
          .read(loggerProvider)
          .d('Found favorite bus stops and processing them');
      for (final favoriteBusStop in favoriteBusStops) {
        final busStops = await busRouteRepo.getBusServicesForBusStopCode(
          busStopCode: favoriteBusStop,
        );

        ref.read(loggerProvider).d('Processing bus stop $favoriteBusStop');
        final existingBusServiceFavorites =
            await localStorageService.getStringList(favoriteServiceNoKey);
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
      ref
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

  Future<bool> isFavorite({
    required String busStopCode,
    required String serviceNo,
  }) async {
    final localStorageService = ref.read(localStorageServiceProvider);
    final searchValue = '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo';

    final currentFavorites =
        await localStorageService.getStringList(favoriteServiceNoKey);

    return currentFavorites.contains(searchValue);
  }
}
