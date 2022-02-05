import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../shared/services/location_service.dart';
import '../bus_database_service.dart';
import '../bus_repository.dart';

final busStopListNearbyViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<BusStopListNearbyViewModel,
        AsyncValue<List<BusStopValueModel>>>(
  (ref) => BusStopListNearbyViewModel(ref.read),
);

class BusStopListNearbyViewModel
    extends StateNotifier<AsyncValue<List<BusStopValueModel>>> {
  BusStopListNearbyViewModel(this.read) : super(const AsyncValue.loading()) {
    init();
  }

  final Reader read;

  Future<void> init() async {
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
      state = const AsyncValue.error(
        'Access to location tracking denied by your device',
      );
    }
  }

  @override
  void dispose() {
    _stopLocationStream();
    super.dispose();
  }

  Future<List<BusStopValueModel>> _getNearbyBusStops({
    required double latitude,
    required double longitude,
  }) async {
    final busDbService = read(busDatabaseServiceProvider);

    // fetch all bus stops from the database and then filter based on the cached
    // result. This is more efficient than querying the local database with a filter
    // every time the location changes, I think... :-)
    final allBusStops = await busDbService.getBusStops();

    return busDbService.filterNearbyBusStops(
      currentLatitude: latitude,
      currentLongitude: longitude,
      busStopList: allBusStops,
    );
  }

  Future<bool> _handleLocationPermission() {
    final locationService = read(locationServiceProvider);
    return locationService.handlePermission();
  }

  Stream<UserLocationModel> _getLocationStream() {
    final locationService = read(locationServiceProvider);
    return locationService.startLocationStream();
  }

  void _stopLocationStream() {
    final locationService = read(locationServiceProvider);
    locationService.stopLocationStream();
  }
}
