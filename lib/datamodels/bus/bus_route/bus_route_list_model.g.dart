// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusRouteListModel _$BusRouteListModelFromJson(Map<String, dynamic> json) {
  return BusRouteListModel(
    json['odata.metadata'] as String,
    (json['value'] as List)
        ?.map((e) => e == null
            ? null
            : BusRouteModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BusRouteListModelToJson(BusRouteListModel instance) =>
    <String, dynamic>{
      'odata.metadata': instance.odataMetadata,
      'value': instance.value,
    };
