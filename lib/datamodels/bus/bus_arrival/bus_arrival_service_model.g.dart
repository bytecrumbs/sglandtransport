// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_arrival_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusArrivalServiceModel _$_$_BusArrivalServiceModelFromJson(
    Map<String, dynamic> json) {
  return _$_BusArrivalServiceModel(
    serviceNo: json['ServiceNo'] as String,
    busOperator: json['Operator'] as String,
    nextBus: json['NextBus'] == null
        ? null
        : NextBusModel.fromJson(json['NextBus'] as Map<String, dynamic>),
    nextBus2: json['NextBus2'] == null
        ? null
        : NextBusModel.fromJson(json['NextBus2'] as Map<String, dynamic>),
    nextBus3: json['NextBus3'] == null
        ? null
        : NextBusModel.fromJson(json['NextBus3'] as Map<String, dynamic>),
    inService: json['inService'] as bool ?? true,
    destinationName: json['destinationName'] as String,
  );
}

Map<String, dynamic> _$_$_BusArrivalServiceModelToJson(
        _$_BusArrivalServiceModel instance) =>
    <String, dynamic>{
      'ServiceNo': instance.serviceNo,
      'Operator': instance.busOperator,
      'NextBus': instance.nextBus,
      'NextBus2': instance.nextBus2,
      'NextBus3': instance.nextBus3,
      'inService': instance.inService,
      'destinationName': instance.destinationName,
    };
