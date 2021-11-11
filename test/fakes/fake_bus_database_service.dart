import 'package:lta_datamall_flutter/src/bus/bus_database_service.dart';

class FakeBusDatabaseService implements BusDatabaseService {
  @override
  Future<List<TableBusStop>> getBusStops(
      {List<String>? favoriteBusStops}) async {
    return [
      TableBusStop(
        busStopCode: '99009',
        description: 'Dest 99009',
      ),
      TableBusStop(
        busStopCode: '75019',
        description: 'Dest 75019',
      ),
      TableBusStop(
        busStopCode: '77009',
        description: 'Dest 77009',
      ),
      TableBusStop(
        busStopCode: '53009',
        description: 'Dest 53009',
      ),
      TableBusStop(
        busStopCode: '75009',
        description: 'Dest 75009',
      ),
    ];
  }

  @override
  Future<List<TableBusRoute>> getBusServiceNosForBusStopCode(
      String busStopCode) async {
    return [
      TableBusRoute(serviceNo: '39'),
      TableBusRoute(serviceNo: '53'),
      TableBusRoute(serviceNo: '81'),
      TableBusRoute(serviceNo: '109'),
      TableBusRoute(serviceNo: '518'),
      TableBusRoute(serviceNo: '53A'),
    ];
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}
