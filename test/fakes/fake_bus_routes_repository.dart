import 'package:lta_datamall_flutter/src/features/bus_routes/data/bus_routes_repository.dart';
import 'package:lta_datamall_flutter/src/features/bus_routes/domain/bus_route_with_bus_stop_info_model.dart';

final fakeBusRouteWithBusStopInfoModelList = [
  BusRouteWithBusStopInfoModel(
    serviceNo: '354',
    direction: 1,
    stopSequence: 6,
    busStopCode: '222333',
    distance: 100,
    roadName: 'RoadName 1',
    description: 'Description 1',
    latitude: 102,
    longitude: 203,
    isPreviousStops: false,
  ),
  BusRouteWithBusStopInfoModel(
    serviceNo: '354',
    direction: 1,
    stopSequence: 7,
    busStopCode: '333444',
    distance: 200,
    roadName: 'RoadName 2',
    description: 'Description 2',
    latitude: 103,
    longitude: 204,
    isPreviousStops: false,
  ),
];

class FakeBusRoutesRepository implements BusRoutesRepository {
  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }

  @override
  Future<List<BusRouteWithBusStopInfoModel>> getBusRoute({
    required String serviceNo,
    required String busStopCode,
    required String destinationCode,
  }) async {
    return Future.value(
      fakeBusRouteWithBusStopInfoModelList,
    );
  }
}
