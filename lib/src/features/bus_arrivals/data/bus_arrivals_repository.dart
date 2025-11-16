import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../environment_config.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_arrival_model.dart';

final busArrivalsRepositoryProvider = Provider<BusArrivalsRepository>(
  BusArrivalsRepository.new,
);

class BusArrivalsRepository extends BaseRepository {
  BusArrivalsRepository(this.ref) : super(ref);

  final Ref ref;

  Future<BusArrivalModel> fetchBusArrivals({
    required String busStopCode,
    String? serviceNo,
  }) async {
    const fetchUrl = '$ltaDatamallApi/v3/BusArrival';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {
        'BusStopCode': busStopCode,
        if (serviceNo != null) 'ServiceNo': serviceNo,
      },
    );

    return BusArrivalModel.fromJson(response.data!);
  }
}
