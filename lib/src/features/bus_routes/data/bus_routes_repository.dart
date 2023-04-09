import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../../database/database.dart';
import '../../../third_party_providers/third_party_providers.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_route_model.dart';
import '../domain/bus_route_value_model.dart';
import '../domain/bus_route_with_bus_stop_info_model.dart';

part 'bus_routes_repository.g.dart';

@Riverpod(keepAlive: true)
BusRoutesRepository busRoutesRepository(BusRoutesRepositoryRef ref) {
  return BusRoutesRepository(ref);
}

class BusRoutesRepository with BaseRepository {
  BusRoutesRepository(this.ref) : super();
  final Ref ref;

  Future<List<BusRouteValueModel>> fetchBusRoutes({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusRoutes';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
      ref: ref,
    );

    return BusRouteModel.fromJson(
      response.data!,
    ).value;
  }

  Future<List<BusRouteWithBusStopInfoModel>> getBusRoute({
    required String serviceNo,
    required String busStopCode,
    required String destinationCode,
  }) async {
    ref
        .read(loggerProvider)
        .d('Getting Bus Route for service $serviceNo from DB');

    final db = ref.read(appDatabaseProvider);
    return db.getBusRoute(
      serviceNo: serviceNo,
      busStopCode: busStopCode,
      destinationCode: destinationCode,
    );
  }

  Future<List<BusRouteValueModel>> getBusServicesForBusStopCode({
    required String busStopCode,
    String? serviceNo,
  }) async {
    ref
        .read(loggerProvider)
        .d('Getting Bus Routes from DB for bus stop $busStopCode');

    final db = ref.read(appDatabaseProvider);
    return db.getBusServicesForBusStopCode(busStopCode: busStopCode);
  }
}
