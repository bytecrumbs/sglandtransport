import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_stop_model.dart';
import '../domain/bus_stop_value_model.dart';

part 'bus_stops_repository.g.dart';

@riverpod
BusStopsRepository busStopsRepository(BusStopsRepositoryRef ref) =>
    BusStopsRepository(ref);

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
}
