import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/bus_arrivals/data/bus_arrivals_repository.dart';
import '../features/bus_routes/data/bus_routes_repository.dart';
import '../features/bus_stops/data/bus_stops_repository.dart';
import '../local_storage/local_storage_service.dart';
import '../third_party_providers/third_party_providers.dart';
import 'tables.dart';

part 'database.g.dart';

class TableBusRouteWithBusStopInfo {
  TableBusRouteWithBusStopInfo(this.route, this.busStop);

  final TableBusRoute route;
  final TableBusStop busStop;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

// keepAlive has been added as otherwise it seems to dispose and recreate
// the DB each time this provider is read.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(AppDatabaseRef ref) => AppDatabase(ref);

@DriftDatabase(tables: [TableBusRoutes, TableBusStops, TableBusServices])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase(this.ref) : super(_openConnection());

  final Ref ref;

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await _handleOutOfCycleBusServiceRefresh(details.wasCreated);

          const refreshDateKey = 'refreshDateKey';
          // get the date of when the database needs to be refreshed
          final refreshDate =
              ref.read(localStorageServiceProvider).getInt(refreshDateKey) ?? 0;
          // refresh the database if it is newly created, or if more than 30
          // days have passed since last refresh
          if (details.wasCreated ||
              refreshDate < DateTime.now().millisecondsSinceEpoch) {
            ref.read(loggerProvider).d('Refreshing tables');
            // add all bus stops into the local database. this has to complete
            // before we show bus stops, as it is fetched from the local DB
            // and not directly from the lta datamall API
            await _refreshBusStops();
            // similar as above, this cannot run in background as it is needed
            // to identify which direction the bus routes should show (plus
            // other things)
            await _refreshBusServices();
            // bus routes loading can run in the background as it is only used
            // to add bus services that are not currently in operation for a given
            // bus stop
            unawaited(_refreshBusRoutes());
            // tables should be refreshed again in 30 days
            final refreshDate = DateTime.now()
                .add(const Duration(days: 30))
                .millisecondsSinceEpoch;

            unawaited(
              ref
                  .read(localStorageServiceProvider)
                  .setInt(refreshDateKey, refreshDate),
            );
          }
        },
      );

  // TODO: this was added as part of a new feature, so we have to make sure
  // it is loaded when the app is opened for the first time since this was
  // introduced. Sometime later, we can remove this again, as it is part of the
  // regular refresh cycle
  Future<void> _handleOutOfCycleBusServiceRefresh(bool wasCreated) async {
    const busServiceOutOfCycleKey = 'busServiceOutOfCycleKey';
    final localStorageService = ref.read(localStorageServiceProvider);
    if (!wasCreated) {
      ref
          .read(loggerProvider)
          .d('Checking if bus services needs to be refreshed as out of cycle');
      final hasAlreadyBeenAddedAsOutOfCycle =
          localStorageService.getBool(busServiceOutOfCycleKey) ?? false;
      if (!hasAlreadyBeenAddedAsOutOfCycle) {
        ref.read(loggerProvider).d('Refreshing bus services as out of cycle');
        final m = Migrator(this);
        await m.createTable(tableBusServices);
        await _refreshBusServices();
      }
    }
    await localStorageService.setBool(
      key: busServiceOutOfCycleKey,
      value: true,
    );
  }

  Future<void> _refreshBusRoutes() async {
    ref.read(loggerProvider).d('deleting bus routes from table');
    await delete(tableBusRoutes).go();
    ref.read(loggerProvider).d('adding bus routes to table');
    for (var i = 0; i <= 26000; i = i + 500) {
      final busRouteValueModelList =
          await ref.read(busRoutesRepositoryProvider).fetchBusRoutes(skip: i);

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

  Future<void> _refreshBusServices() async {
    ref.read(loggerProvider).d('deleting bus services from table');
    await delete(tableBusServices).go();
    ref.read(loggerProvider).d('adding bus services to table');
    for (var i = 0; i <= 500; i = i + 500) {
      final busServiceValueModelList = await ref
          .read(busArrivalsRepositoryProvider)
          .fetchBusServices(skip: i);

      final busServiceValueTableList = busServiceValueModelList.map(
        (e) => TableBusService(
          serviceNo: e.serviceNo,
          operator: e.busOperator,
          direction: e.direction,
          category: e.category,
          originCode: e.originCode,
          destinationCode: e.destinationCode,
          amPeakFreq: e.amPeakFreq,
          amOffpeakFreq: e.amOffpeakFreq,
          pmPeakFreq: e.pmPeakFreq,
          pmOffpeakFreq: e.pmOffpeakFreq,
          loopDesc: e.loopDesc,
        ),
      );

      await batch((batch) {
        // functions in a batch don't have to be awaited - just
        // await the whole batch afterwards.
        batch.insertAll(tableBusServices, [...busServiceValueTableList]);
      });
    }
  }

  Future<void> _refreshBusStops() async {
    ref.read(loggerProvider).d('deleting bus stops from table');
    await delete(tableBusStops).go();
    ref.read(loggerProvider).d('adding bus stops to table');
    for (var i = 0; i <= 5000; i = i + 500) {
      final busStopValueModelList =
          await ref.read(busStopsRepositoryProvider).fetchBusStops(skip: i);

      final busStopValueTableList = busStopValueModelList.map(
        (e) => TableBusStop(
          busStopCode: e.busStopCode,
          description: e.description,
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
}
