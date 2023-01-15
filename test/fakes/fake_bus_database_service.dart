import 'package:lta_datamall_flutter/src/features/bus_stops/application/bus_database_service.dart';

class FakeBusDatabaseService implements BusDatabaseService {
  @override
  Future<List<TableBusStop>> getBusStops({
    List<String>? favoriteBusStops,
  }) async {
    return [
      const TableBusStop(
        busStopCode: '99009',
        description: 'Dest 99009',
      ),
      const TableBusStop(
        busStopCode: '75019',
        description: 'Dest 75019',
      ),
      const TableBusStop(
        busStopCode: '77009',
        description: 'Dest 77009',
      ),
      const TableBusStop(
        busStopCode: '53009',
        description: 'Dest 53009',
      ),
      const TableBusStop(
        busStopCode: '75009',
        description: 'Dest 75009',
      ),
    ];
  }

  @override
  Future<List<TableBusRoute>> getBusServiceNosForBusStopCode(
    String busStopCode,
  ) async {
    return [
      const TableBusRoute(serviceNo: '39'),
      const TableBusRoute(serviceNo: '53'),
      const TableBusRoute(serviceNo: '81'),
      const TableBusRoute(serviceNo: '109'),
      const TableBusRoute(serviceNo: '518'),
      const TableBusRoute(serviceNo: '53A'),
    ];
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}
