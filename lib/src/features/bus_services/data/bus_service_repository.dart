import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_service_model.dart';
import '../domain/bus_service_value_model.dart';

part 'bus_service_repository.g.dart';

@riverpod
BusServiceRepository busServiceRepository(BusServiceRepositoryRef ref) =>
    BusServiceRepository(ref);

class BusServiceRepository extends BaseRepository {
  BusServiceRepository(this.ref) : super(ref);

  final Ref ref;

  Future<List<BusServiceValueModel>> fetchBusServices({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusServices';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
    );

    return BusServiceModel.fromJson(
      response.data!,
    ).value;
  }
}
