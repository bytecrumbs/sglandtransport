import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/location_service.dart';
import '../data/bus_local_repository.dart';
import '../domain/bus_stop_value_model.dart';

final busStopListNearbyControllerStateNotifierProvider =
    StateNotifierProvider.autoDispose<BusStopListNearbyController,
        AsyncValue<List<BusStopValueModel>>>(
  BusStopListNearbyController.new,
);

class BusStopListNearbyController
    extends StateNotifier<AsyncValue<List<BusStopValueModel>>> {
  BusStopListNearbyController(this._ref) : super(const AsyncValue.loading()) {
    init();
  }

  final Ref _ref;

  Future<void> init() async {
    await startLocationStream();
  }

  @override
  void dispose() {
    stopLocationStream();
    super.dispose();
  }

  Future<List<BusStopValueModel>> _getNearbyBusStops({
    required double latitude,
    required double longitude,
  }) async {
    final busDbService = _ref.read(busLocalRepositoryProvider);

    // fetch all bus stops from the database and then filter based on the cached
    // result. This is more efficient than querying the local database with a filter
    // every time the location changes, I think... :-)
    final allBusStops = await busDbService.getAllBusStops();

    return busDbService.filterNearbyBusStops(
      currentLatitude: latitude,
      currentLongitude: longitude,
      busStopList: allBusStops,
    );
  }

  Future<bool> _handleLocationPermission() {
    final locationService = _ref.read(locationServiceProvider);
    return locationService.handlePermission();
  }

  Future<void> startLocationStream() async {
    final hasPermission = await _handleLocationPermission();
    if (hasPermission) {
      final locationStream = _getLocationStream();

      await for (final locationData in locationStream) {
        final busStopList = await _getNearbyBusStops(
          latitude: locationData.latitude,
          longitude: locationData.longitude,
        );
        state = AsyncValue.data(busStopList);
      }
    } else {
      state = AsyncValue.error(
        'Access to location tracking denied by your device',
        StackTrace.current,
      );
    }
  }

  Stream<UserLocationModel> _getLocationStream() {
    final locationService = _ref.read(locationServiceProvider);
    return locationService.startLocationStream();
  }

  void stopLocationStream() {
    _ref.read(locationServiceProvider).stopLocationStream();
  }
}
