// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_stop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusStopModel _$_$_BusStopModelFromJson(Map<String, dynamic> json) {
  return _$_BusStopModel(
    busStopCode: json['BusStopCode'] as String,
    roadName: json['RoadName'] as String,
    description: json['Description'] as String,
    latitude: (json['Latitude'] as num)?.toDouble(),
    longitude: (json['Longitude'] as num)?.toDouble(),
    distanceInMeters: json['distanceInMeters'] as int,
  );
}

Map<String, dynamic> _$_$_BusStopModelToJson(_$_BusStopModel instance) =>
    <String, dynamic>{
      'BusStopCode': instance.busStopCode,
      'RoadName': instance.roadName,
      'Description': instance.description,
      'Latitude': instance.latitude,
      'Longitude': instance.longitude,
      'distanceInMeters': instance.distanceInMeters,
    };
