// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusRouteModel _$BusRouteModelFromJson(Map<String, dynamic> json) {
  return BusRouteModel(
    serviceNo: json['ServiceNo'] as String,
    busOperator: json['Operator'] as String,
    busStopCode: json['BusStopCode'] as String,
    direction: json['Direction'] as int,
    distance: (json['Distance'] as num)?.toDouble(),
    satFirstBus: json['SAT_FirstBus'] as String,
    satLastBus: json['SAT_LastBus'] as String,
    stopSequence: json['StopSequence'] as int,
    sunFirstBus: json['SUN_FirstBus'] as String,
    sunLastBus: json['SUN_LastBus'] as String,
    wdFirstBus: json['WD_FirstBus'] as String,
    wdLastBus: json['WD_LastBus'] as String,
  );
}

Map<String, dynamic> _$BusRouteModelToJson(BusRouteModel instance) =>
    <String, dynamic>{
      'ServiceNo': instance.serviceNo,
      'Operator': instance.busOperator,
      'Direction': instance.direction,
      'StopSequence': instance.stopSequence,
      'BusStopCode': instance.busStopCode,
      'Distance': instance.distance,
      'WD_FirstBus': instance.wdFirstBus,
      'WD_LastBus': instance.wdLastBus,
      'SAT_FirstBus': instance.satFirstBus,
      'SAT_LastBus': instance.satLastBus,
      'SUN_FirstBus': instance.sunFirstBus,
      'SUN_LastBus': instance.sunLastBus,
    };
