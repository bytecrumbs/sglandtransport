import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:lta_datamall_flutter/services/database_service.dart';
import 'package:http/io_client.dart' as http;

@lazySingleton
class BusService {
  static final _log = Logger('BusService');
  final _databaseService = locator<DatabaseService>();
  final _api = locator<Api>();

  Future<List<BusStopModel>> getNearbyBusStops() {
    _log.info('getting bus stops');
    final userLocation = UserLocation(latitude: 1.29785, longitude: 103.853);
    return _getBusStopsByLocation(userLocation.latitude, userLocation.latitude);
  }

  Future<List<BusStopModel>> _getBusStopsByLocation(
      double userLatitude, double userLongitude) async {
    var data = await _databaseService.getBusStopsByLocation(
        userLatitude, userLongitude);
    return data.isNotEmpty ? data : _fetchBusStopsFromServer();
  }

  Future<List<BusStopModel>> _fetchBusStopsFromServer() async {
    final busStops = await _api.fetchBusStopList(http.IOClient());
    _databaseService.updateBusStopsByLocation(busStops);
    return busStops;
  }
}
