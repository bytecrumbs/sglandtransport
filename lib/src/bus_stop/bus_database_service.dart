import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../shared/common_providers.dart';
import 'bus_repository.dart';

part 'bus_database_service.g.dart';

class TableBusRoutes extends Table {
  TextColumn get serviceNo => text().nullable()();
  TextColumn get operator => text().nullable()();
  IntColumn get direction => integer().nullable()();
  IntColumn get stopSequence => integer().nullable()();
  TextColumn get busStopCode => text().nullable()();
  RealColumn get distance => real().nullable()();
  TextColumn get wdFirstBus => text().nullable()();
  TextColumn get wdLastBus => text().nullable()();
  TextColumn get satFirstBus => text().nullable()();
  TextColumn get satLastBus => text().nullable()();
  TextColumn get sunFirstBus => text().nullable()();
  TextColumn get sunLastBus => text().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

final busDatabaseServiceProvider =
    Provider<BusDatabaseService>((ref) => BusDatabaseService(ref.read));

@DriftDatabase(tables: [TableBusRoutes])
class BusDatabaseService extends _$BusDatabaseService {
  // we tell the database where to store the data with this constructor
  BusDatabaseService(this._read) : super(_openConnection());

  final Reader _read;

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          // TODO: tables need to be refreshed periodically, not just when it is created the first times
          if (details.wasCreated) {
            _read(loggerProvider).d('Refreshing tables');
            // this can run in the background, no need to wait for it
            // ignore: unawaited_futures
            _refreshBusRoutes();
          }
        },
      );

  Future<List<TableBusRoute>> getBusServiceNoForBusStopCode(
      String busStopCode) {
    _read(loggerProvider)
        .d('Getting Bus Routes from DB for bus stop $busStopCode');
    return (select(tableBusRoutes)
          ..where((tbl) => tbl.busStopCode.equals(busStopCode)))
        .get();
  }

  Future<void> _refreshBusRoutes() async {
    _read(loggerProvider).d('deleting bus routes from table');
    await delete(tableBusRoutes).go();
    _read(loggerProvider).d('adding bus routes to table');
    for (var i = 0; i <= 26000; i = i + 500) {
      final busRouteValueModelList =
          await _read(busRepositoryProvider).fetchBusRoutes(skip: i);

      final busRouteValueTableList = busRouteValueModelList.map(
        (e) => TableBusRoute(
          serviceNo: e.serviceNo,
          operator: e.busOperator,
          direction: e.direction,
          stopSequence: e.stopSequence,
          busStopCode: e.busStopCode,
          distance: e.distance,
          wdFirstBus: e.wdFirstBus,
          wdLastBus: e.wdLastBus,
          satFirstBus: e.satFirstBus,
          satLastBus: e.satLastBus,
          sunFirstBus: e.sunFirstBus,
          sunLastBus: e.sunLastBus,
        ),
      );

      // this can run in the background, no need to wait for it
      // ignore: unawaited_futures
      batch((batch) {
        // functions in a batch don't have to be awaited - just
        // await the whole batch afterwards.
        batch.insertAll(tableBusRoutes, [...busRouteValueTableList]);
      });
    }
  }
}
