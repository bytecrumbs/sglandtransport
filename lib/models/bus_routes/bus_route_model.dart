import 'package:json_annotation/json_annotation.dart';

part 'bus_route_model.g.dart';

@JsonSerializable()
class BusRouteModel {
  BusRouteModel({
    this.serviceNo,
    this.busOperator,
    this.busStopCode,
    this.direction,
    this.distance,
    this.satFirstBus,
    this.satLastBus,
    this.stopSequence,
    this.sunFirstBus,
    this.sunLastBus,
    this.wdFirstBus,
    this.wdLastBus,
  });

  @JsonKey(name: 'ServiceNo')
  final String serviceNo;
  @JsonKey(name: 'Operator')
  final String busOperator;
  @JsonKey(name: 'Direction')
  final int direction;
  @JsonKey(name: 'StopSequence')
  final int stopSequence;
  @JsonKey(name: 'BusStopCode')
  final String busStopCode;
  @JsonKey(name: 'Distance')
  final double distance;
  @JsonKey(name: 'WD_FirstBus')
  final String wdFirstBus;
  @JsonKey(name: 'WD_LastBus')
  final String wdLastBus;
  @JsonKey(name: 'SAT_FirstBus')
  final String satFirstBus;
  @JsonKey(name: 'SAT_LastBus')
  final String satLastBus;
  @JsonKey(name: 'SUN_FirstBus')
  final String sunFirstBus;
  @JsonKey(name: 'SUN_LastBus')
  final String sunLastBus;

  factory BusRouteModel.fromJson(Map<String, dynamic> json) =>
      _$BusRouteModelFromJson(json);

  Map<String, dynamic> toJson() => _$BusRouteModelToJson(this);
}
