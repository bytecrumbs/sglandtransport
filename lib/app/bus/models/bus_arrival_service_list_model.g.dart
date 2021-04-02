// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_arrival_service_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusArrivalServiceListModel _$_$_BusArrivalServiceListModelFromJson(
    Map<String, dynamic> json) {
  return _$_BusArrivalServiceListModel(
    odataMetadata: json['odata.metadata'] as String,
    busStopCode: json['BusStopCode'] as String,
    services: (json['Services'] as List<dynamic>)
        .map((e) => e == null
            ? null
            : BusArrivalServiceModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_BusArrivalServiceListModelToJson(
        _$_BusArrivalServiceListModel instance) =>
    <String, dynamic>{
      'odata.metadata': instance.odataMetadata,
      'BusStopCode': instance.busStopCode,
      'Services': instance.services,
    };
