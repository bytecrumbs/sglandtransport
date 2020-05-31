import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/db/database.dart';
import 'package:lta_datamall_flutter/models/bus_routes/bus_route_model.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:http/io_client.dart' as http;

class DatabaseProvider {
  static final _log = Logger('DatabaseProvider');
  BusRoutesDatabase _db;

  static final DatabaseProvider dbProvider = DatabaseProvider._internal();

  DatabaseProvider._internal() {
    _db = BusRoutesDatabase.get();
  }

  Future<BusRoutesDatabase> get database async {
    _log.info('fetchBusRoutes called...');
    final busRoutes = await fetchBusRoutes(http.IOClient());

    _log.info('database updateBusRoutes called...');
    await _db.updateBusRoutes(busRoutes);

    _log.info('return database with updated data');
    return _db;
  }

  Future<List<BusRouteModel>> getBusRoutes(String busStopCode) async {
    return _db.getBusRoutes(busStopCode);
  }
}
