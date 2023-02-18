import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/data/local_db_repository.dart';
import '../../bus_stops/domain/bus_stop_value_model.dart';

part 'bus_routes_service.g.dart';

@riverpod
BusRoutesService busRoutesService(BusRoutesServiceRef ref) =>
    BusRoutesService(ref);

class BusRoutesService {
  BusRoutesService(this.ref);

  final Ref ref;

  Future<List<BusStopValueModel>> getBusRoute({
    required String busStopCode,
    required String serviceNo,
    required String originalCode,
    required String destinationCode,
  }) async {
    final repository = ref.read(localDbRepositoryProvider);

    final busServiceValueModelList = await repository.getBusService(
      serviceNo: serviceNo,
      originalCode: originalCode,
      destinationCode: destinationCode,
    );

    // If the bus is not in service, we are not getting 'originalCode' and
    // 'destinationCode" - hence defaulting it to 1.
    var direction = 1;
    if (busServiceValueModelList.isNotEmpty) {
      direction = busServiceValueModelList[0].direction;
    }
    return repository.getBusRoute(
      busStopCode: busStopCode,
      serviceNo: serviceNo,
      direction: direction,
    );
  }
}
