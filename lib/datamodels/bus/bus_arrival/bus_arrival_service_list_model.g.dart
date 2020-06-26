// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_arrival_service_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusArrivalServiceListModel _$BusArrivalServiceListModelFromJson(
    Map<String, dynamic> json) {
  return BusArrivalServiceListModel(
    odataMetadata: json['odata.metadata'] as String,
    busStopCode: json['BusStopCode'] as String,
    services: (json['Services'] as List)
        ?.map((e) => e == null
            ? null
            : BusArrivalServiceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BusArrivalServiceListModelToJson(
        BusArrivalServiceListModel instance) =>
    <String, dynamic>{
      'odata.metadata': instance.odataMetadata,
      'BusStopCode': instance.busStopCode,
      'Services': instance.services,
    };
