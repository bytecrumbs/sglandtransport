import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/common_providers.dart';
import '../shared/constants.dart';
import '../shared/custom_exception.dart';
import '../shared/environment_config.dart';
import '../shared/palette.dart';

part 'bus_repository.freezed.dart';
part 'bus_repository.g.dart';

final busRepositoryProvider =
    Provider<BusRepository>((ref) => BusRepository(ref.read));

class BusRepository {
  BusRepository(this._read);

  final Reader _read;

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
    final dio = _read(dioProvider);
    _read(loggerProvider)
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
    @JsonKey(name: 'Services') required List<BusArrivalServicesModel> services,
    String? roadName,
    String? description,
  }) = _BusArrivalModel;

  factory BusArrivalModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalModelFromJson(json);
}

@freezed
class BusArrivalServicesModel with _$BusArrivalServicesModel {
  factory BusArrivalServicesModel({
    @JsonKey(name: 'ServiceNo') required String serviceNo,
    @JsonKey(name: 'Operator') required String busOperator,
    @JsonKey(name: 'NextBus') required NextBusModel nextBus,
    @JsonKey(name: 'NextBus2') required NextBusModel nextBus2,
    @JsonKey(name: 'NextBus3') required NextBusModel nextBus3,
    @Default(true) bool inService,
    @Default(false) bool isFavorite,
    String? destinationName,
  }) = _BusArrivalServicesModel;

  /// Named constructor to convert from Json to a proper model
  factory BusArrivalServicesModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalServicesModelFromJson(json);
}

@freezed
class NextBusModel with _$NextBusModel {
  factory NextBusModel({
    @JsonKey(name: 'OriginCode') String? originCode,
    @JsonKey(name: 'DestinationCode') String? destinationCode,
    @JsonKey(name: 'EstimatedArrival') String? estimatedArrivalAbsolute,
    @JsonKey(name: 'Latitude') String? latitude,
    @JsonKey(name: 'Longitude') String? longitude,
    @JsonKey(name: 'VisitNumber') String? visitNumber,
    @JsonKey(name: 'Load') String? load,
    @JsonKey(name: 'Feature') String? feature,
    @JsonKey(name: 'Type') String? type,
  }) = _NextBusModel;

  NextBusModel._();

  factory NextBusModel.fromJson(Map<String, dynamic> json) =>
      _$NextBusModelFromJson(json);

  // All derived bus arrival duration should be rounded down to the nearest minute.
  String getEstimatedArrival() {
    if (estimatedArrivalAbsolute != null && estimatedArrivalAbsolute != '') {
      final arrivalDateTime = DateTime.parse(estimatedArrivalAbsolute!);
      // ignore milliseconds in the calculation
      final arrivalDateTimeTrimmed = DateTime(
        arrivalDateTime.year,
        arrivalDateTime.month,
        arrivalDateTime.day,
        arrivalDateTime.hour,
        arrivalDateTime.minute,
        arrivalDateTime.second,
      );
      final now = DateTime.now().toUtc();
      // ignore milliseconds in the calculation
      final nowTrimmed = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
      );
      final arrivalInMinutes =
          arrivalDateTimeTrimmed.difference(nowTrimmed).inSeconds;
      if (arrivalInMinutes <= 59) {
        return 'Arr';
      } else {
        return '${arrivalInMinutes ~/ 60}min';
      }
    } else {
      return 'n/a';
    }
  }

  Color getLoadColor() {
    switch (load) {
      case 'SEA':
        return kLoadSeatsAvailable;
      case 'SDA':
        return kLoadStandingAvailable;
      case 'LDS':
        return kLoadLimitedStanding;
      default:
        return kLoadSeatsAvailable;
    }
  }
}

@freezed
class BusRouteModel with _$BusRouteModel {
  factory BusRouteModel({
    @JsonKey(name: 'odata.metadata') required String odataMetadata,
    required List<BusRouteValueModel> value,
  }) = _BusRouteModel;

  /// Named constructor to convert from Json to a proper model
  factory BusRouteModel.fromJson(Map<String, dynamic> json) =>
      _$BusRouteModelFromJson(json);
}

@freezed
class BusRouteValueModel with _$BusRouteValueModel {
  factory BusRouteValueModel({
    @JsonKey(name: 'ServiceNo') String? serviceNo,
    @JsonKey(name: 'Operator') String? busOperator,
    @JsonKey(name: 'Direction') int? direction,
    @JsonKey(name: 'StopSequence') int? stopSequence,
    @JsonKey(name: 'BusStopCode') String? busStopCode,
    @JsonKey(name: 'Distance') double? distance,
    @JsonKey(name: 'WD_FirstBus') String? wdFirstBus,
    @JsonKey(name: 'WD_LastBus') String? wdLastBus,
    @JsonKey(name: 'SAT_FirstBus') String? satFirstBus,
    @JsonKey(name: 'SAT_LastBus') String? satLastBus,
    @JsonKey(name: 'SUN_FirstBus') String? sunFirstBus,
    @JsonKey(name: 'SUN_LastBus') String? sunLastBus,
  }) = _BusRouteValueModel;

  /// Named constructor to convert from Json to a proper model
  factory BusRouteValueModel.fromJson(Map<String, dynamic> json) =>
      _$BusRouteValueModelFromJson(json);
}

@freezed
class BusStopModel with _$BusStopModel {
  factory BusStopModel({
    @JsonKey(name: 'odata.metadata') required String odataMetadata,
    required List<BusStopValueModel> value,
  }) = _BusStopModel;

  /// Named constructor to convert from Json to a proper model
  factory BusStopModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopModelFromJson(json);
}

@freezed
class BusStopValueModel with _$BusStopValueModel {
  factory BusStopValueModel({
    @JsonKey(name: 'BusStopCode') String? busStopCode,
    @JsonKey(name: 'RoadName') String? roadName,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'Latitude') double? latitude,
    @JsonKey(name: 'Longitude') double? longitude,
    int? distanceInMeters,
  }) = _BusStopValueModel;

  /// Named constructor to convert from Json to a proper model
  factory BusStopValueModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopValueModelFromJson(json);
}
