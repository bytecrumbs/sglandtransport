import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../environment_config.dart';
import '../../../database/database.dart';
import '../../../third_party_providers/third_party_providers.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_route_model.dart';
import '../domain/bus_route_value_model.dart';
import '../domain/bus_route_with_bus_stop_info_model.dart';

final busRoutesRepositoryProvider = Provider<BusRoutesRepository>(
  BusRoutesRepository.new,
);

class BusRoutesRepository extends BaseRepository {
  BusRoutesRepository(this.ref) : super(ref);

  final Ref ref;

  Future<List<BusRouteValueModel>> fetchBusRoutes({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusRoutes';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
    );

    return BusRouteModel.fromJson(response.data!).value;
  }

  Future<List<BusRouteWithBusStopInfoModel>> getBusRoute({
    required String serviceNo,
    required String busStopCode,
    required String destinationCode,
  }) async {
    refBase
        .read(loggerProvider)
        .d('Getting Bus Route for service $serviceNo from DB');

    final db = refBase.read(appDatabaseProvider);
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
    refBase
        .read(loggerProvider)
        .d('Getting Bus Routes from DB for bus stop $busStopCode');

    final db = refBase.read(appDatabaseProvider);
    return db.getBusServicesForBusStopCode(busStopCode: busStopCode);
  }
}
