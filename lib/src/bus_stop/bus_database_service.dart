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

class TableBusStops extends Table {
  TextColumn get busStopCode => text().nullable()();
  TextColumn get roadName => text().nullable()();
  TextColumn get description => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
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

@DriftDatabase(tables: [TableBusRoutes, TableBusStops])
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
            // add all bus stops into the local database. this has to complete
            // before we show bus stops, as it is fetched from the local DB
            // and not directly from the lta datamall API
            await _refreshBusStops();
            // bus routes loading can run in the background as it is only used
            // to add bus services that are not currently in operation for a given
            // bus stop
            // ignore: unawaited_futures
            _refreshBusRoutes();
          }
        },
      );

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

      await batch((batch) {
        // functions in a batch don't have to be awaited - just
        // await the whole batch afterwards.
        batch.insertAll(tableBusRoutes, [...busRouteValueTableList]);
      });
    }
  }

  Future<void> _refreshBusStops() async {
    _read(loggerProvider).d('deleting bus stops from table');
    await delete(tableBusStops).go();
    _read(loggerProvider).d('adding bus stops to table');
    for (var i = 0; i <= 5000; i = i + 500) {
      final busStopValueModelList =
          await _read(busRepositoryProvider).fetchBusStops(skip: i);

      final busStopValueTableList = busStopValueModelList.map(
        (e) => TableBusStop(
          busStopCode: e.busStopCode,
          description: e.descritption,
          roadName: e.roadName,
          latitude: e.latitude,
          longitude: e.longitude,
        ),
      );

      await batch((batch) {
        // functions in a batch don't have to be awaited - just
        // await the whole batch afterwards.
        batch.insertAll(tableBusStops, [...busStopValueTableList]);
      });
    }
  }

  Future<List<TableBusRoute>> getBusServicesNoForBusStopCode(
      String busStopCode) {
    _read(loggerProvider)
        .d('Getting Bus Routes from DB for bus stop $busStopCode');
    return (select(tableBusRoutes)
          ..where((tbl) => tbl.busStopCode.equals(busStopCode)))
        .get();
  }
}
