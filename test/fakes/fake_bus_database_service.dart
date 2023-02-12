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
  Future<List<BusRouteValueModel>> getBusServicesForBusStopCode({
    required String busStopCode,
    String? serviceNo,
  }) async {
    return [
      BusRouteValueModel(
        serviceNo: '39',
        busOperator: 'SBST',
        busStopCode: '01219',
        direction: 1,
        distance: 10.3,
        satFirstBus: '1427',
        satLastBus: '2349',
        stopSequence: 28,
        sunFirstBus: '0620',
        sunLastBus: '2349',
        wdFirstBus: '2025',
        wdLastBus: '2352',
      ),
      BusRouteValueModel(
        serviceNo: '53',
        busOperator: 'SBST',
        busStopCode: '01219',
        direction: 1,
        distance: 10.3,
        satFirstBus: '1427',
        satLastBus: '2349',
        stopSequence: 28,
        sunFirstBus: '0620',
        sunLastBus: '2349',
        wdFirstBus: '2025',
        wdLastBus: '2352',
      ),
      BusRouteValueModel(
        serviceNo: '81',
        busOperator: 'SBST',
        busStopCode: '01219',
        direction: 1,
        distance: 10.3,
        satFirstBus: '1427',
        satLastBus: '2349',
        stopSequence: 28,
        sunFirstBus: '0620',
        sunLastBus: '2349',
        wdFirstBus: '2025',
        wdLastBus: '2352',
      ),
      BusRouteValueModel(
        serviceNo: '109',
        busOperator: 'SBST',
        busStopCode: '01219',
        direction: 1,
        distance: 10.3,
        satFirstBus: '1427',
        satLastBus: '2349',
        stopSequence: 28,
        sunFirstBus: '0620',
        sunLastBus: '2349',
        wdFirstBus: '2025',
        wdLastBus: '2352',
      ),
      BusRouteValueModel(
        serviceNo: '518',
        busOperator: 'SBST',
        busStopCode: '01219',
        direction: 1,
        distance: 10.3,
        satFirstBus: '1427',
        satLastBus: '2349',
        stopSequence: 28,
        sunFirstBus: '0620',
        sunLastBus: '2349',
        wdFirstBus: '2025',
        wdLastBus: '2352',
      ),
      BusRouteValueModel(
        serviceNo: '53A',
        busOperator: 'SBST',
        busStopCode: '01219',
        direction: 1,
        distance: 10.3,
        satFirstBus: '1427',
        satLastBus: '2349',
        stopSequence: 28,
        sunFirstBus: '0620',
        sunLastBus: '2349',
        wdFirstBus: '2025',
        wdLastBus: '2352',
      ),
    ];
  }

  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }
}
