// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_route_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusRouteListModel _$_$_BusRouteListModelFromJson(Map<String, dynamic> json) {
  return _$_BusRouteListModel(
    odataMetadata: json['odata.metadata'] as String?,
    value: (json['value'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : BusRouteModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_BusRouteListModelToJson(
        _$_BusRouteListModel instance) =>
    <String, dynamic>{
      'odata.metadata': instance.odataMetadata,
      'value': instance.value,
    };
