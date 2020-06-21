import 'package:injectable/injectable.dart';
import 'package:latlong/latlong.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:lta_datamall_flutter/services/database_service.dart';
import 'package:http/io_client.dart' as http;

@lazySingleton
class BusService {
  static final _log = Logger('BusService');
  final _databaseService = locator<DatabaseService>();
  var _nearbyBusStops = <BusStopModel>[];
  final _api = locator<Api>();

  List<BusStopModel> get nearbyBusStops => _nearbyBusStops;

  void nearbyBusStopsByLocation(UserLocation userLocation) async {
    _log.info('getting bus stops');
    _nearbyBusStops = [];

    if (userLocation != null && userLocation.permissionGranted) {
      final distance = Distance();
      var allBusStops = await _getBusStopsByLocation();

      allBusStops.forEach((busStop) {
        final distanceInMeters = distance(
          LatLng(userLocation.latitude, userLocation.longitude),
          LatLng(busStop.latitude, busStop.longitude),
        );
        if (distanceInMeters <= 500) {
          busStop.distanceInMeters = distanceInMeters.round();
          _nearbyBusStops.add(busStop);
        }
      });

      _nearbyBusStops.sort((BusStopModel a, BusStopModel b) =>
          a.distanceInMeters.compareTo(b.distanceInMeters));
    }
  }

  Future<List<BusArrivalServiceModel>> getBusArrivalServices(
      String busStopCode) async {
    _log.info('getting bus arrival list for bus stop $busStopCode');
    var busArrivalServiceListModel =
        await _api.fetchBusArrivalList(http.IOClient(), busStopCode);
    _log.info('getting all bus services for $busStopCode from bus routes DB');
    var allBusServices = await _databaseService.getBusRoutes(busStopCode);
    // add services not in use to the original api result
    return busArrivalServiceListModel.services;
  }

  Future<void> addBusRoutesToDb() async {
    _log.info('checking if table is empty');
    var count = await _databaseService.getBusRoutesCount();
    if (count == 0) {
      _log.info('fetching bus routes from server');
      var busRoutes = await _api.fetchBusRoutes(http.IOClient());
      _log.info('adding bus routes information into DB');
      _databaseService.insertBusRoutes(busRoutes);
    }
  }

  Future<List<BusStopModel>> _getBusStopsByLocation() async {
    var data = await _databaseService.getBusStopsByLocation();
    return data.isNotEmpty ? data : _fetchBusStopsFromServer();
  }

  Future<List<BusStopModel>> _fetchBusStopsFromServer() async {
    final busStops = await _api.fetchBusStopList(http.IOClient());
    _databaseService.insertBusStops(busStops);
    return busStops;
  }
}
