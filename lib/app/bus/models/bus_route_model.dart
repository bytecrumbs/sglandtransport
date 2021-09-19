import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_route_model.freezed.dart';
part 'bus_route_model.g.dart';

@freezed

/// Freezed model of BusRouteModel
class BusRouteModel with _$BusRouteModel {
  /// Factory constructor for freezed model
  factory BusRouteModel({
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
  }) = _BusRouteModel;

  /// Named constructor to convert from Json to a proper model
  factory BusRouteModel.fromJson(Map<String, dynamic> json) =>
      _$BusRouteModelFromJson(json);
}
