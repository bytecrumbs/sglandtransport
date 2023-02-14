import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/environment_config.dart';
import '../../../shared/custom_exception.dart';
import '../../../shared/third_party_providers.dart';
import '../domain/bus_stop_model.dart';
import '../domain/bus_stop_value_model.dart';

part 'bus_stops_repository.g.dart';

@riverpod
BusStopsRepository busStopsRepository(BusStopsRepositoryRef ref) =>
    BusStopsRepository(ref);

class BusStopsRepository {
  BusStopsRepository(this.ref);

  final Ref ref;

  Future<List<BusStopValueModel>> fetchBusStops({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusStops';

    final response = await _get<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
    );

    return BusStopModel.fromJson(
      response.data!,
    ).value;
  }

  Future<Response<T>> _get<T>(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final dio = ref.read(dioProvider);
    ref
        .read(loggerProvider)
        .d('GET $path with $queryParameters as query parameters');

    try {
      return await dio.get<T>(
        path,
        options: Options(
          headers: <String, String>{
            'AccountKey': EnvironmentConfig.ltaDatamallApiKey,
          },
        ),
        queryParameters: queryParameters,
      );
    } on DioError catch (e) {
      ref
          .read(loggerProvider)
          .e('message: ${e.message}; response: ${e.response}');
      throw CustomException.fromDioError(e);
    }
  }
}
