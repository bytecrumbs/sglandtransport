import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/bus_routes/data/bus_routes_repository.dart';
import '../features/bus_routes/domain/bus_route_value_model.dart';
import '../features/bus_routes/domain/bus_route_with_bus_stop_info_model.dart';
import '../features/bus_services/data/bus_service_repository.dart';
import '../features/bus_services/domain/bus_service_value_model.dart';
import '../features/bus_stops/data/bus_stops_repository.dart';
import '../features/bus_stops/domain/bus_stop_value_model.dart';
import '../local_storage/local_storage_service.dart';
import '../third_party_providers/third_party_providers.dart';
import 'db_init_notifier.dart';
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
          final refreshDate = await ref
                  .read(localStorageServiceProvider)
                  .getInt(refreshDateKey) ??
              0;
          // refresh the database if it is newly created, or if more than 30
          // days have passed since last refresh
          if (details.wasCreated ||
              refreshDate < DateTime.now().millisecondsSinceEpoch) {
            ref.read(loggerProvider).d('Refreshing tables');
            ref.watch(dBInitNotifierProvider.notifier).initDBStart();

            /// Add all bus information into the local database. The most stable
            /// way to do that seems to be to load one table after another
            /// syncronous. Maybe this can be improved in a future release by
            /// try to run those in parallel again, or if not show a nicer message
            /// on the UI that this is being loaded.
            await _refreshBusStops();
            await _refreshBusServices();
            await _refreshBusRoutes();

            // tables should be refreshed again in 30 days
            final refreshDate = DateTime.now()
                .add(const Duration(days: 30))
                .millisecondsSinceEpoch;

            await ref
                .read(localStorageServiceProvider)
                .setInt(refreshDateKey, refreshDate);

            ref.watch(dBInitNotifierProvider.notifier).initDBComplete();
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
          await localStorageService.getBool(busServiceOutOfCycleKey) ?? false;
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
    ref.watch(dBInitNotifierProvider.notifier).busRoutesLoadingUpdate(0);
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

      final percentComplete = (100 / 26000 * i).round();
      ref
          .watch(dBInitNotifierProvider.notifier)
          .busRoutesLoadingUpdate(percentComplete);
    }
    ref.watch(dBInitNotifierProvider.notifier).busRoutesLoadingComplete();
  }

  Future<void> _refreshBusServices() async {
    ref.read(loggerProvider).d('deleting bus services from table');
    ref.watch(dBInitNotifierProvider.notifier).busServicesLoadingUpdate(0);
    await delete(tableBusServices).go();
    ref.read(loggerProvider).d('adding bus services to table');
    for (var i = 0; i <= 500; i = i + 500) {
      final busServiceValueModelList = await ref
          .read(busServiceRepositoryProvider)
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

      final percentComplete = (100 / 500 * i).round();
      ref
          .watch(dBInitNotifierProvider.notifier)
          .busServicesLoadingUpdate(percentComplete);
    }
    ref.watch(dBInitNotifierProvider.notifier).busServicesLoadingComplete();
  }

  Future<void> _refreshBusStops() async {
    ref.read(loggerProvider).d('deleting bus stops from table');
    ref.watch(dBInitNotifierProvider.notifier).busStopsLoadingUpdate(0);
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
      final percentComplete = (100 / 5000 * i).round();
      ref
          .watch(dBInitNotifierProvider.notifier)
          .busStopsLoadingUpdate(percentComplete);
    }
    ref.watch(dBInitNotifierProvider.notifier).busStopsLoadingComplete();
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

  JoinedSelectStatement<$TableBusServicesTable, TableBusService>
      getBusDirection({
    required String serviceNo,
    required String destinationCode,
  }) =>
          selectOnly(tableBusServices)
            ..addColumns([tableBusServices.direction])
            ..where(
              tableBusServices.serviceNo.equals(serviceNo) &
                  tableBusServices.destinationCode.equals(destinationCode),
            );

  Future<List<BusServiceValueModel>> getBusService({
    required String serviceNo,
    required String destinationCode,
  }) async {
    ref
        .read(loggerProvider)
        .d('Getting Bus Service from DB for service $serviceNo');

    final direction = getBusDirection(
      serviceNo: serviceNo,
      destinationCode: destinationCode,
    );

    final tableBusServicesList = await (select(tableBusServices)
          ..where(
            (tbl) =>
                tbl.serviceNo.equals(serviceNo) &
                tbl.direction.equalsExp(subqueryExpression(direction)),
          ))
        .get();

    return _busServiceTableToFreezed(tableBusServicesList);
  }

  List<BusServiceValueModel> _busServiceTableToFreezed(
    List<TableBusService> tableBusService,
  ) =>
      tableBusService
          .map(
            (e) => BusServiceValueModel(
              serviceNo: e.serviceNo,
              busOperator: e.operator,
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
          )
          .toList();

  JoinedSelectStatement<$TableBusRoutesTable, TableBusRoute> getStopSequence({
    required String serviceNo,
    required String busStopCode,
    required String destinationCode,
  }) {
    final direction = getBusDirection(
      serviceNo: serviceNo,
      destinationCode: destinationCode,
    );

    return selectOnly(tableBusRoutes)
      ..addColumns([tableBusRoutes.stopSequence])
      ..where(
        tableBusRoutes.serviceNo.equals(serviceNo) &
            tableBusRoutes.busStopCode.equals(busStopCode) &
            tableBusRoutes.direction.equalsExp(subqueryExpression(direction)),
      );
  }

  Future<List<BusRouteWithBusStopInfoModel>> getBusRoute({
    required String serviceNo,
    required String busStopCode,
    required String destinationCode,
  }) async {
    ref
        .read(loggerProvider)
        .d('Getting Bus Route for service $serviceNo from DB');

    final direction = getBusDirection(
      serviceNo: serviceNo,
      destinationCode: destinationCode,
    );

    /// If for some reason the bus route information is not loaded, try
    /// to load it again
    final checkForBusRouteAvailability = await (select(tableBusRoutes)
          ..where(
            (t) =>
                t.serviceNo.equals(serviceNo) &
                t.direction.equalsExp(subqueryExpression(direction)),
          ))
        .get();
    if (checkForBusRouteAvailability.isEmpty) {
      ref
          .read(loggerProvider)
          .d('BusRoutes Table seems empty - trying to reload');
      await _refreshBusRoutes();
    }

    final stopSequence = getStopSequence(
      serviceNo: serviceNo,
      busStopCode: busStopCode,
      destinationCode: destinationCode,
    );

    final tableBusRouteList = (select(tableBusStops).join([
      innerJoin(
        tableBusRoutes,
        tableBusRoutes.busStopCode.equalsExp(tableBusStops.busStopCode),
      ),
    ])
      ..where(
        tableBusRoutes.serviceNo.equals(serviceNo) &
            tableBusRoutes.direction.equalsExp(subqueryExpression(direction)) &
            tableBusRoutes.stopSequence
                .isBiggerOrEqual(subqueryExpression(stopSequence)),
      ))
      ..orderBy([OrderingTerm.asc(tableBusRoutes.stopSequence)]);
    final result = await tableBusRouteList.get();

    final tableBusRouteWithBusStopInfo = result.map((row) {
      return TableBusRouteWithBusStopInfo(
        row.readTable(tableBusRoutes),
        row.readTable(tableBusStops),
      );
      // return row.readTable(tableBusStops);
    }).toList();

    return _busRouteTableWithBusStopInfoToFreezed(tableBusRouteWithBusStopInfo);
  }

  List<BusRouteWithBusStopInfoModel> _busRouteTableWithBusStopInfoToFreezed(
    List<TableBusRouteWithBusStopInfo> tableBusRouteWithBusStopInfo,
  ) =>
      tableBusRouteWithBusStopInfo
          .map(
            (e) => BusRouteWithBusStopInfoModel(
              busStopCode: e.busStop.busStopCode,
              serviceNo: e.route.serviceNo,
              direction: e.route.direction,
              stopSequence: e.route.stopSequence,
              distance: e.route.distance,
              roadName: e.busStop.roadName,
              description: e.busStop.description,
              latitude: e.busStop.latitude,
              longitude: e.busStop.longitude,
            ),
          )
          .toList();

  List<BusRouteValueModel> _busRouteTableToFreezed(
    List<TableBusRoute> tableBusRoute,
  ) =>
      tableBusRoute
          .map(
            (e) => BusRouteValueModel(
              serviceNo: e.serviceNo,
              busOperator: e.operator,
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
          )
          .toList();

  Future<List<BusRouteValueModel>> getBusServicesForBusStopCode({
    required String busStopCode,
    String? serviceNo,
  }) async {
    ref
        .read(loggerProvider)
        .d('Getting Bus Routes from DB for bus stop $busStopCode');
    final tableBusRouteList = await (select(tableBusRoutes)
          ..where(
            (tbl) => serviceNo != null
                ? tbl.busStopCode.equals(busStopCode) &
                    tbl.serviceNo.equalsNullable(serviceNo)
                : tbl.busStopCode.equals(busStopCode),
          ))
        .get();

    return _busRouteTableToFreezed(tableBusRouteList);
  }
}
