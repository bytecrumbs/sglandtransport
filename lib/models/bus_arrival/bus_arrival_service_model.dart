import 'package:json_annotation/json_annotation.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/next_bus_model.dart';

part 'bus_arrival_service_model.g.dart';

@JsonSerializable()
class BusArrivalServiceModel {
  BusArrivalServiceModel({
    this.serviceNo,
    this.busOperator,
    this.nextBus,
    this.nextBus2,
    this.nextBus3,
  });

  factory BusArrivalServiceModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalServiceModelFromJson(json);

  @JsonKey(name: 'ServiceNo')
  final String serviceNo;
  @JsonKey(name: 'Operator')
  final String busOperator;
  @JsonKey(name: 'NextBus')
  final NextBusModel nextBus;
  @JsonKey(name: 'NextBus2')
  final NextBusModel nextBus2;
  @JsonKey(name: 'NextBus3')
  final NextBusModel nextBus3;

  Map<String, dynamic> toJson() => _$BusArrivalServiceModelToJson(this);
}
