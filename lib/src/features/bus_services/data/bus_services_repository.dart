import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/environment_config.dart';
import '../../../shared/custom_exception.dart';
import '../../../shared/third_party_providers.dart';
import '../domain/bus_arrival_model.dart';
import '../domain/bus_route_model.dart';
import '../domain/bus_route_value_model.dart';
import '../domain/bus_service_model.dart';
import '../domain/bus_service_value_model.dart';

part 'bus_services_repository.g.dart';

@riverpod
BusServicesRepository busServicesRepository(BusServicesRepositoryRef ref) =>
    BusServicesRepository(ref);

class BusServicesRepository {
  BusServicesRepository(this._ref);

  final Ref _ref;

  Future<BusArrivalModel> fetchBusArrivals({
    required String busStopCode,
    String? serviceNo,
  }) async {
    const fetchUrl = '$ltaDatamallApi/BusArrivalv2';

    final response = await _get<Map<String, Object?>>(
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

  Future<List<BusServiceValueModel>> fetchBusServices({int skip = 0}) async {
    const fetchUrl = '$ltaDatamallApi/BusServices';

    final response = await _get<Map<String, Object?>>(
      fetchUrl,
      queryParameters: {r'$skip': skip},
    );

    return BusServiceModel.fromJson(
      response.data!,
    ).value;
  }

  Future<Response<T>> _get<T>(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final dio = _ref.read(dioProvider);
    _ref
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
      _ref
          .read(loggerProvider)
          .e('message: ${e.message}; response: ${e.response}');
      await FirebaseCrashlytics.instance
          .log('Catching DIO error. Message: ${e.message}');
      throw CustomException.fromDioError(e);
    }
  }
}
