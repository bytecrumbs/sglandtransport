import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/bus_stops_service.dart';
import '../application/location_service.dart';
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

  Future<bool> _handleLocationPermission() {
    final locationService = _ref.read(locationServiceProvider);
    return locationService.handlePermission();
  }

  Future<void> startLocationStream() async {
    final hasPermission = await _handleLocationPermission();
    if (hasPermission) {
      final locationStream = _getLocationStream();

      await for (final locationData in locationStream) {
        final busStopList =
            await _ref.read(busStopsServiceProvider).getNearbyBusStops(
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
