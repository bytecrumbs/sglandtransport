import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/db/database.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
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

  Future<BusArrivalModel> getBusArrivalList(final String busStopCode) async {
    _log.info('getBusArrivalList called...');

    var futureResult = await Future.wait([
      fetchBusArrivalList(http.IOClient(), busStopCode),
      _db.getBusRoutes(busStopCode),
    ]);

    return await compute(filterBusArrivalList, futureResult);
  }

  Future close() async {
    return _db.close();
  }

  static BusArrivalModel filterBusArrivalList(List<Object> futureResult) {
    _log.info('filterBusArrivalList called...with compute');

    final BusArrivalModel busArrivalModel = futureResult[0];
    List<BusRouteModel> busRouteModelList = futureResult[1];

    if (busArrivalModel.services.length < busRouteModelList.length) {
      final busRouteModelServiceNos =
          busRouteModelList.map((e) => e.serviceNo).toList();
      final busArrivalServiceNoss =
          busArrivalModel.services.map((e) => e.serviceNo).toList();

      final busNoDifferences = busRouteModelServiceNos
          .toSet()
          .difference(busArrivalServiceNoss.toSet())
          .toList();
      busNoDifferences.forEach((element) {
        final missingBusArrivalServiceModel = BusArrivalServiceModel(
          serviceNo: element,
          inService: false,
        );
        busArrivalModel.services.add(missingBusArrivalServiceModel);
      });
    }

    _log.info('filterBusArrivalList operation done...with compute');
    return busArrivalModel;
  }
}
