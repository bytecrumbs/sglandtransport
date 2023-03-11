import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../../database/database.dart';
import '../../../database/tables.dart';
import '../../../third_party_providers/third_party_providers.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_stop_model.dart';
import '../domain/bus_stop_value_model.dart';

part 'bus_stops_repository.g.dart';

@Riverpod(keepAlive: true)
BusStopsRepository busStopsRepository(BusStopsRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return BusStopsRepository(ref, db);
}

@DriftAccessor(tables: [TableBusStops])
class BusStopsRepository extends DatabaseAccessor<AppDatabase>
    with _$BusStopsRepositoryMixin, BaseRepository {
  BusStopsRepository(this.ref, AppDatabase db) : super(db);

  final Ref ref;

  Future<List<BusStopValueModel>> fetchBusStops({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusStops';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
      ref: ref,
    );

    return BusStopModel.fromJson(
      response.data!,
    ).value;
  }

  List<BusStopValueModel> _busStopTableToFreezed(
    List<TableBusStop> tableBusStop,
  ) =>
      tableBusStop
          .map(
            (e) => BusStopValueModel(
              busStopCode: e.busStopCode,
              roadName: e.roadName,
              description: e.description,
              latitude: e.latitude,
              longitude: e.longitude,
            ),
          )
          .toList();

  Future<List<BusStopValueModel>> getAllBusStops() async {
    ref.read(loggerProvider).d('Getting all Bus Stops from DB');
    final tableBusStopList = await select(tableBusStops).get();

    return _busStopTableToFreezed(tableBusStopList);
  }

  Future<List<BusStopValueModel>> getBusStops({
    required List<String> busStopCodes,
  }) async {
    ref.read(loggerProvider).d('Getting Bus Stops $busStopCodes from DB');

    final tableBusStopList = await (select(tableBusStops)
          ..where((tbl) => tbl.busStopCode.isIn(busStopCodes)))
        .get();

    return _busStopTableToFreezed(tableBusStopList);
  }

  Future<List<BusStopValueModel>> findBusStops(String searchTerm) async {
    ref
        .read(loggerProvider)
        .d('Getting Bus Stops from DB with search term $searchTerm');

    final tableBusStopList = await (select(tableBusStops)
          ..where(
            (tbl) =>
                tbl.description.contains(searchTerm) |
                tbl.busStopCode.contains(searchTerm) |
                tbl.roadName.contains(searchTerm),
          ))
        .get();

    return _busStopTableToFreezed(tableBusStopList);
  }
}
