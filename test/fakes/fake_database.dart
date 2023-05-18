import 'package:lta_datamall_flutter/src/database/database.dart';
import 'package:lta_datamall_flutter/src/features/bus_routes/domain/bus_route_with_bus_stop_info_model.dart';
import 'package:lta_datamall_flutter/src/features/bus_services/domain/bus_service_value_model.dart';
import 'package:lta_datamall_flutter/src/features/bus_stops/domain/bus_stop_value_model.dart';

final fakeBusStopValueModel = BusStopValueModel(
  busStopCode: '111222',
  roadName: 'Bus Road Name',
  description: 'Bus Description',
  latitude: 101,
  longitude: 202,
  distanceInMeters: 123,
);

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
  ),
];

final fakeBusServiceValueModel = BusServiceValueModel(
  serviceNo: '354',
  busOperator: 'SBST',
  direction: 1,
  category: 'TRUNK',
  originCode: '65009',
  destinationCode: '97009',
  amPeakFreq: '5-08',
  amOffpeakFreq: '8-12',
  pmPeakFreq: '8-10',
  pmOffpeakFreq: '09-14',
);

const String testExceptionServiceNo = 'exception';
const String testExceptionDestinationCode = 'exception';

class FakeAppDatabase implements AppDatabase {
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

  @override
  Future<List<BusServiceValueModel>> getBusService({
    required String serviceNo,
    required String destinationCode,
  }) async {
    if (serviceNo == testExceptionServiceNo &&
        destinationCode == testExceptionDestinationCode) {
      throw Exception('Throwing exception');
    }
    return Future.value([
      fakeBusServiceValueModel.copyWith(
        serviceNo: serviceNo,
        destinationCode: destinationCode,
      ),
    ]);
  }

  @override
  Future<List<BusStopValueModel>> getBusStops({
    required List<String> busStopCodes,
  }) async {
    return Future.value([fakeBusStopValueModel]);
  }
}
