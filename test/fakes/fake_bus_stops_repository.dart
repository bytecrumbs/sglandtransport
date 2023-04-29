import 'package:lta_datamall_flutter/src/features/bus_stops/data/bus_stops_repository.dart';
import 'package:lta_datamall_flutter/src/features/bus_stops/domain/bus_stop_value_model.dart';

final fakeBusStopValueModel = BusStopValueModel(
  busStopCode: '111222',
  roadName: 'Bus Road Name',
  description: 'Bus Description',
  latitude: 101,
  longitude: 202,
  distanceInMeters: 123,
);

class FakeBusStopsRepository implements BusStopsRepository {
  @override
  void noSuchMethod(Invocation invocation) {
    throw UnimplementedError();
  }

  @override
  Future<List<BusStopValueModel>> getBusStops({
    required List<String> busStopCodes,
  }) {
    return Future.value([fakeBusStopValueModel]);
  }
}
