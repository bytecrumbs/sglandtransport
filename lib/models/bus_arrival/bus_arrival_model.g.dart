// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_arrival_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusArrivalModel _$BusArrivalModelFromJson(Map<String, dynamic> json) {
  return BusArrivalModel(
    odataMetadata: json['odata.metadata'] as String,
    busStopCode: json['BusStopCode'] as String,
    services: (json['Services'] as List)
        ?.map((e) => e == null
            ? null
            : BusArrivalServiceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BusArrivalModelToJson(BusArrivalModel instance) =>
    <String, dynamic>{
      'odata.metadata': instance.odataMetadata,
      'BusStopCode': instance.busStopCode,
      'Services': instance.services,
    };
