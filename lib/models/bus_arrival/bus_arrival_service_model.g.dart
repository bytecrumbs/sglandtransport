// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_arrival_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusArrivalServiceModel _$BusArrivalServiceModelFromJson(
    Map<String, dynamic> json) {
  return BusArrivalServiceModel(
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
    inService: json['inService'] as bool,
  );
}

Map<String, dynamic> _$BusArrivalServiceModelToJson(
        BusArrivalServiceModel instance) =>
    <String, dynamic>{
      'ServiceNo': instance.serviceNo,
      'Operator': instance.busOperator,
      'NextBus': instance.nextBus,
      'NextBus2': instance.nextBus2,
      'NextBus3': instance.nextBus3,
      'inService': instance.inService,
    };
