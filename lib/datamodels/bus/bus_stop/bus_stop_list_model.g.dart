// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_stop_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusStopListModel _$BusStopListModelFromJson(Map<String, dynamic> json) {
  return BusStopListModel(
    json['odata.metadata'] as String,
    (json['value'] as List)
        ?.map((e) =>
            e == null ? null : BusStopModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BusStopListModelToJson(BusStopListModel instance) =>
    <String, dynamic>{
      'odata.metadata': instance.odataMetadata,
      'value': instance.value,
    };
