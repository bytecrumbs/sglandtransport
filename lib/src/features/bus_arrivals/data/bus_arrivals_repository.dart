import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_arrival_model.dart';

part 'bus_arrivals_repository.g.dart';

@Riverpod(keepAlive: true)
BusArrivalsRepository busArrivalsRepository(BusArrivalsRepositoryRef ref) =>
    BusArrivalsRepository(ref);

class BusArrivalsRepository extends BaseRepository {
  BusArrivalsRepository(this.ref) : super(ref);

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
    );

    return BusArrivalModel.fromJson(
      response.data!,
    );
  }
}
