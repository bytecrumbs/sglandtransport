import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../../database/database.dart';
import '../../../third_party_providers/third_party_providers.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_stop_model.dart';
import '../domain/bus_stop_value_model.dart';

part 'bus_stops_repository.g.dart';

@Riverpod(keepAlive: true)
BusStopsRepository busStopsRepository(BusStopsRepositoryRef ref) {
  return BusStopsRepository(ref);
}

class BusStopsRepository extends BaseRepository {
  BusStopsRepository(this.ref) : super(ref);

  final Ref ref;

  Future<List<BusStopValueModel>> fetchBusStops({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusStops';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
    );

    return BusStopModel.fromJson(
      response.data!,
    ).value;
  }

  Future<List<BusStopValueModel>> getAllBusStops() {
    refBase.read(loggerProvider).d('Getting all Bus Stops from DB');
    final db = refBase.read(appDatabaseProvider);
    return db.getAllBusStops();
  }

  Future<List<BusStopValueModel>> getBusStops({
    required List<String> busStopCodes,
  }) {
    refBase.read(loggerProvider).d('Getting Bus Stops $busStopCodes from DB');

    final db = refBase.read(appDatabaseProvider);
    return db.getBusStops(busStopCodes: busStopCodes);
  }

  Future<List<BusStopValueModel>> findBusStops(String searchTerm) {
    refBase
        .read(loggerProvider)
        .d('Getting Bus Stops from DB with search term $searchTerm');

    final db = refBase.read(appDatabaseProvider);
    return db.findBusStops(searchTerm);
  }
}
