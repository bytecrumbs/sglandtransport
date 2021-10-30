import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../shared/common_providers.dart';
import '../shared/constants.dart';
import '../shared/custom_exception.dart';
import '../shared/environment_config.dart';

part 'bus_repository.freezed.dart';
part 'bus_repository.g.dart';

final busRepositoryProvider =
    Provider<BusRepository>((ref) => BusRepository(ref.read));

class BusRepository {
  BusRepository(this._read);

  final Reader _read;

  Future<List<BusArrivalDetailsModel>> fetchBusArrivals(
      String busStopCode) async {
    const fetchUrl = '$ltaDatamallApi/BusArrivalv2';

    final response = await _get(
      fetchUrl,
      queryParameters: {
        'BusStopCode': busStopCode,
      },
    );

    return BusArrivalModel.fromJson(
      response.data as Map<String, dynamic>,
    ).services;
  }

  Future<Response<dynamic>> _get(
    String path, {
    Map<String, Object>? queryParameters,
  }) async {
    final dio = _read(dioProvider);
    _read(loggerProvider)
        .d('GET $path with $queryParameters as query parameters');

    try {
      return await dio.get<Map<String, dynamic>>(path,
          options: Options(
            headers: <String, String>{
              'AccountKey': EnvironmentConfig.ltaDatamallApiKey,
            },
          ),
          queryParameters: queryParameters);
    } on DioError catch (e) {
      _read(loggerProvider).e('message: ${e.message}; response: ${e.response}');
      throw CustomException.fromDioError(e);
    }
  }
}

@freezed
class BusArrivalModel with _$BusArrivalModel {
  factory BusArrivalModel({
    @JsonKey(name: 'odata.metadata') required String odataMetadata,
    @JsonKey(name: 'BusStopCode') required String busStopCode,
    @JsonKey(name: 'Services') required List<BusArrivalDetailsModel> services,
  }) = _BusArrivalModel;

  factory BusArrivalModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalModelFromJson(json);
}

@freezed
class BusArrivalDetailsModel with _$BusArrivalDetailsModel {
  factory BusArrivalDetailsModel({
    @JsonKey(name: 'ServiceNo') required String serviceNo,
    @JsonKey(name: 'Operator') required String busOperator,
    @JsonKey(name: 'NextBus') required NextBusModel nextBus,
    @JsonKey(name: 'NextBus2') required NextBusModel nextBus2,
    @JsonKey(name: 'NextBus3') required NextBusModel nextBus3,
    @Default(true) bool inService,
    String? destinationName,
  }) = _BusArrivalDetailsModel;

  /// Named constructor to convert from Json to a proper model
  factory BusArrivalDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalDetailsModelFromJson(json);
}

@freezed
class NextBusModel with _$NextBusModel {
  factory NextBusModel({
    @JsonKey(name: 'OriginCode') String? originCode,
    @JsonKey(name: 'DestinationCode') String? destinationCode,
    @JsonKey(name: 'EstimatedArrival') String? estimatedArrival,
    @JsonKey(name: 'Latitude') String? latitude,
    @JsonKey(name: 'Longitude') String? longitude,
    @JsonKey(name: 'VisitNumber') String? visitNumber,
    @JsonKey(name: 'Load') String? load,
    @JsonKey(name: 'Feature') String? feature,
    @JsonKey(name: 'Type') String? type,
  }) = _NextBusModel;

  factory NextBusModel.fromJson(Map<String, dynamic> json) =>
      _$NextBusModelFromJson(json);
}
