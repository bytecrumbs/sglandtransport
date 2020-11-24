// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusRouteModel _$_$_BusRouteModelFromJson(Map<String, dynamic> json) {
  return _$_BusRouteModel(
    serviceNo: json['ServiceNo'] as String,
    busOperator: json['Operator'] as String,
    direction: json['Direction'] as int,
    stopSequence: json['StopSequence'] as int,
    busStopCode: json['BusStopCode'] as String,
    distance: (json['Distance'] as num)?.toDouble(),
    wdFirstBus: json['WD_FirstBus'] as String,
    wdLastBus: json['WD_LastBus'] as String,
    satFirstBus: json['SAT_FirstBus'] as String,
    satLastBus: json['SAT_LastBus'] as String,
    sunFirstBus: json['SUN_FirstBus'] as String,
    sunLastBus: json['SUN_LastBus'] as String,
  );
}

Map<String, dynamic> _$_$_BusRouteModelToJson(_$_BusRouteModel instance) =>
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
