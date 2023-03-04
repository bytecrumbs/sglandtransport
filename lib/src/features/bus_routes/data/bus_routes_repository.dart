import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_route_model.dart';
import '../domain/bus_route_value_model.dart';

part 'bus_routes_repository.g.dart';

@riverpod
BusRoutesRepository busRoutesRepository(BusRoutesRepositoryRef ref) =>
    BusRoutesRepository(ref);

class BusRoutesRepository extends BaseRepository {
  BusRoutesRepository(this.ref) : super(ref);

  final Ref ref;

  Future<List<BusRouteValueModel>> fetchBusRoutes({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusRoutes';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
    );

    return BusRouteModel.fromJson(
      response.data!,
    ).value;
  }
}
