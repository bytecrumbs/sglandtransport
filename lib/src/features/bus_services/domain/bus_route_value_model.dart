import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_route_value_model.freezed.dart';
part 'bus_route_value_model.g.dart';

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
