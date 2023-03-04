import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../environment_config.dart';
import '../../../custom_exception.dart';
import '../../../third_party_providers/third_party_providers.dart';
import '../domain/bus_route_model.dart';
import '../domain/bus_route_value_model.dart';

part 'bus_routes_repository.g.dart';

@riverpod
BusRoutesRepository busRoutesRepository(BusRoutesRepositoryRef ref) =>
    BusRoutesRepository(ref);

class BusRoutesRepository {
  BusRoutesRepository(this.ref);

  final Ref ref;

  Future<List<BusRouteValueModel>> fetchBusRoutes({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusRoutes';

    final response = await _get<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
    );

    return BusRouteModel.fromJson(
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
      await FirebaseCrashlytics.instance
          .log('Catching DIO error. Message: ${e.message}');
      throw CustomException.fromDioError(e);
    }
  }
}
