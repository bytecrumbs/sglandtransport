import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../../database/database.dart';
import '../../../database/tables.dart';
import '../../../third_party_providers/third_party_providers.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_service_model.dart';
import '../domain/bus_service_value_model.dart';

part 'bus_service_repository.g.dart';

@Riverpod(keepAlive: true)
BusServiceRepository busServiceRepository(BusServiceRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return BusServiceRepository(ref, db);
}

@DriftAccessor(tables: [TableBusServices])
class BusServiceRepository extends DatabaseAccessor<AppDatabase>
    with _$BusServiceRepositoryMixin, BaseRepository {
  BusServiceRepository(this.ref, AppDatabase db) : super(db);

  final Ref ref;

  Future<List<BusServiceValueModel>> fetchBusServices({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusServices';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
      ref: ref,
    );

    return BusServiceModel.fromJson(
      response.data!,
    ).value;
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
}
