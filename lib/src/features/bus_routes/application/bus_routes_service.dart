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
    required int direction,
  }) async {
    final repository = ref.read(localDbRepositoryProvider);

    return repository.getBusRoute(
      serviceNo: serviceNo,
      direction: direction,
    );
  }
}
