import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong/latlong.dart';

import '../../services/api.dart';
import '../../services/database_service.dart';
import 'models/bus_stop_model.dart';

/// Provides the View Model for the BusNearbyView
final busNearbyViewModelProvider =
    Provider((ref) => BusNearbyViewModel(ref.read));

/// The view model class for the BusNearbyView
class BusNearbyViewModel {
  /// constructor for the model
  BusNearbyViewModel(this.read);

  /// a reader that enables reading other providers
  final Reader read;

  /// get all the bus stops with the following checks:
  /// if the table is already populated, reload it if it is older than 30 days
  /// if it is not yet populated, fetch it from the API and populate the DB
  Future<List<BusStopModel>> getBusStops() async {
    final _databaseService = read(databaseServiceProvider);

    var allBusStops = <BusStopModel>[];
    final creationDateRecord =
        await _databaseService.getCreationDateOfBusStops();
    if (creationDateRecord.isNotEmpty) {
      final creationDateMillisecondsSinceEpoch =
          creationDateRecord.first['creationTimeSinceEpoch'] as int;
      final creationDate = DateTime.fromMillisecondsSinceEpoch(
          creationDateMillisecondsSinceEpoch);
      final differenceInDays = DateTime.now().difference(creationDate).inDays;
      if (differenceInDays > 30) {
        allBusStops = await populateBusStopsDbfromApi();
      } else {
        allBusStops = await getBusStopsFromDb();
      }
    } else {
      allBusStops = await populateBusStopsDbfromApi();
    }
    return allBusStops;
  }

  /// fetches all bus stops from the database
  Future<List<BusStopModel>> getBusStopsFromDb() async {
    return read(databaseServiceProvider).getBusStops();
  }

  /// Get the bus stops from the API and store the result in the DB. It also
  /// adds a record into the "audit" table so that we know when the table has
  /// last been refreshed.
  Future<List<BusStopModel>> populateBusStopsDbfromApi() async {
    final _databaseService = read(databaseServiceProvider);
    final _api = read(apiProvider);

    final allBusStops = await _api.fetchBusStopList();
    await _databaseService.deleteBusStops();
    await _databaseService.insertBusStops(allBusStops);
    await _databaseService.insertBusStopsTableCreationDate(
        millisecondsSinceEpoch: DateTime.now().millisecondsSinceEpoch);
    return allBusStops;
  }

  /// returns bus stops that are nearby a given latitude and longitude
  List<BusStopModel> filterBusStopsByLocation(
    List<BusStopModel> busStopModelList,
    double latitude,
    double longitude,
  ) {
    final nearbyBusStops = <BusStopModel>[];
    const distance = Distance();

    // filter DB result by location
    for (final busStop in busStopModelList) {
      final distanceInMeters = distance(
        LatLng(latitude, longitude),
        LatLng(busStop.latitude, busStop.longitude),
      );
      if (distanceInMeters <= 500) {
        final newBusStop =
            busStop.copyWith(distanceInMeters: distanceInMeters.round());

        nearbyBusStops.add(newBusStop);
      }
    }
    // sort result by distance
    nearbyBusStops.sort(
        (var a, var b) => a.distanceInMeters.compareTo(b.distanceInMeters));

    return nearbyBusStops;
  }
}
