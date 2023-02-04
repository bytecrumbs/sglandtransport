import 'package:lta_datamall_flutter/src/features/bus_services/domain/bus_route_value_model.dart';
import 'package:lta_datamall_flutter/src/features/bus_stops/domain/bus_stop_value_model.dart';
import 'package:lta_datamall_flutter/src/shared/data/local_db_repository.dart';

class FakeLocalDbRepository implements LocalDbRepository {
  @override
  Future<List<BusStopValueModel>> getBusStops({
    required List<String> busStopCodes,
  }) async {
    return [
      BusStopValueModel(
        busStopCode: '99009',
        description: 'Dest 99009',
      ),
      BusStopValueModel(
        busStopCode: '75019',
        description: 'Dest 75019',
      ),
      BusStopValueModel(
        busStopCode: '77009',
        description: 'Dest 77009',
      ),
      BusStopValueModel(
        busStopCode: '53009',
        description: 'Dest 53009',
      ),
      BusStopValueModel(
        busStopCode: '75009',
        description: 'Dest 75009',
      ),
    ];
  }

  @override
  Future<List<BusRouteValueModel>> getBusServicesForBusStopCode(
    String busStopCode,
  ) async {
    return [
      BusRouteValueModel(serviceNo: '39'),
      BusRouteValueModel(serviceNo: '53'),
      BusRouteValueModel(serviceNo: '81'),
      BusRouteValueModel(serviceNo: '109'),
      BusRouteValueModel(serviceNo: '518'),
      BusRouteValueModel(serviceNo: '53A'),
    ];
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}
