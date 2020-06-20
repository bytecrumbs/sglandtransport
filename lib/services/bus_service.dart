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
    var result = await _api.fetchBusArrivalList(http.IOClient(), busStopCode);
    return result.services;
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
