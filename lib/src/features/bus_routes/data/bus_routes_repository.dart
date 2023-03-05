import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../../database/database.dart';
import '../../../database/tables.dart';
import '../../../third_party_providers/third_party_providers.dart';
import '../../bus_services/data/bus_service_repository.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_route_model.dart';
import '../domain/bus_route_value_model.dart';
import '../domain/bus_route_with_bus_stop_info_model.dart';

part 'bus_routes_repository.g.dart';

@riverpod
BusRoutesRepository busRoutesRepository(BusRoutesRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return BusRoutesRepository(ref, db);
}

@DriftAccessor(tables: [TableBusRoutes, TableBusStops])
class BusRoutesRepository extends DatabaseAccessor<AppDatabase>
    with _$BusRoutesRepositoryMixin, BaseRepository {
  BusRoutesRepository(this.ref, AppDatabase db) : super(db);
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

  JoinedSelectStatement<$TableBusRoutesTable, TableBusRoute> getStopSequence({
    required String serviceNo,
    required String busStopCode,
    required String destinationCode,
  }) {
    final direction = ref.read(busServiceRepositoryProvider).getBusDirection(
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

    final direction = ref.read(busServiceRepositoryProvider).getBusDirection(
          serviceNo: serviceNo,
          destinationCode: destinationCode,
        );

    final stopSequence = getStopSequence(
      serviceNo: serviceNo,
      busStopCode: busStopCode,
      destinationCode: destinationCode,
    );

    final tableBusRouteList = (select(tableBusStops).join([
      innerJoin(
        tableBusRoutes,
        tableBusRoutes.busStopCode.equalsExp(tableBusStops.busStopCode),
      )
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
