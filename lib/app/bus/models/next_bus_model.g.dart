// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_bus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NextBusModel _$_$_NextBusModelFromJson(Map<String, dynamic> json) {
  return _$_NextBusModel(
    originCode: json['OriginCode'] as String?,
    destinationCode: json['DestinationCode'] as String?,
    estimatedArrival: json['EstimatedArrival'] as String?,
    latitude: json['Latitude'] as String?,
    longitude: json['Longitude'] as String?,
    visitNumber: json['VisitNumber'] as String?,
    load: json['Load'] as String?,
    feature: json['Feature'] as String?,
    type: json['Type'] as String?,
  );
}

Map<String, dynamic> _$_$_NextBusModelToJson(_$_NextBusModel instance) =>
    <String, dynamic>{
      'OriginCode': instance.originCode,
      'DestinationCode': instance.destinationCode,
      'EstimatedArrival': instance.estimatedArrival,
      'Latitude': instance.latitude,
      'Longitude': instance.longitude,
      'VisitNumber': instance.visitNumber,
      'Load': instance.load,
      'Feature': instance.feature,
      'Type': instance.type,
    };
