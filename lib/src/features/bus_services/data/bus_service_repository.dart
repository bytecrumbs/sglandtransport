import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../environment_config.dart';
import '../../../database/database.dart';
import '../../../third_party_providers/third_party_providers.dart';
import '../../shared/data/base_repository.dart';
import '../domain/bus_service_model.dart';
import '../domain/bus_service_value_model.dart';

final busServiceRepositoryProvider = Provider<BusServiceRepository>(
  BusServiceRepository.new,
);

class BusServiceRepository extends BaseRepository {
  BusServiceRepository(this.ref) : super(ref);

  final Ref ref;

  Future<List<BusServiceValueModel>> fetchBusServices({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusServices';

    final response = await fetch<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
    );

    return BusServiceModel.fromJson(response.data!).value;
  }

  Future<List<BusServiceValueModel>> getBusService({
    required String serviceNo,
    required String destinationCode,
  }) async {
    refBase
        .read(loggerProvider)
        .d('Getting Bus Service from DB for service $serviceNo');

    final db = refBase.read(appDatabaseProvider);
    return db.getBusService(
      serviceNo: serviceNo,
      destinationCode: destinationCode,
    );
  }
}
