import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lta_datamall_flutter/app/bus/models/bus_stop_model.dart';

final databaseServiceProvider = Provider((ref) => DatabaseService());

class DatabaseService {
  Future<List<BusStopModel>> getNearbyBusStops(
      double latitude, double longitude) {
    var result = <BusStopModel>[];
    result.add(BusStopModel(busStopCode: latitude.toString()));
    return Future.value(result);
  }
}
