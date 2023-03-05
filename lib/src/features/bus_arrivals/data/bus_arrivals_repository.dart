import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../bus_services/domain/bus_service_model.dart';
import '../../bus_services/domain/bus_service_value_model.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_arrival_model.dart';

part 'bus_arrivals_repository.g.dart';

@riverpod
BusArrivalsRepository busArrivalsRepository(BusArrivalsRepositoryRef ref) =>
    BusArrivalsRepository(ref);

class BusArrivalsRepository with BaseRepository {
  BusArrivalsRepository(this.ref);

  final Ref ref;

  Future<BusArrivalModel> fetchBusArrivals({
    required String busStopCode,
    String? serviceNo,
  }) async {
    const fetchUrl = '$ltaDatamallApi/BusArrivalv2';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {
        'BusStopCode': busStopCode,
        if (serviceNo != null) 'ServiceNo': serviceNo,
      },
      ref: ref,
    );

    return BusArrivalModel.fromJson(
      response.data!,
    );
  }

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
}
