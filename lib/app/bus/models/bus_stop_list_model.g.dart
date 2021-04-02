// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_stop_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusStopListModel _$_$_BusStopListModelFromJson(Map<String, dynamic> json) {
  return _$_BusStopListModel(
    odataMetadata: json['odata.metadata'] as String,
    value: (json['value'] as List<dynamic>)
        .map((e) =>
            e == null ? null : BusStopModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_BusStopListModelToJson(
        _$_BusStopListModel instance) =>
    <String, dynamic>{
      'odata.metadata': instance.odataMetadata,
      'value': instance.value,
    };
