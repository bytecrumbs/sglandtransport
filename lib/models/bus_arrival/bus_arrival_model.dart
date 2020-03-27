import 'package:json_annotation/json_annotation.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';

part 'bus_arrival_model.g.dart';

@JsonSerializable()
class BusArrivalModel {
  BusArrivalModel({
    this.odataMetadata,
    this.busStopCode,
    this.services,
  });

  factory BusArrivalModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalModelFromJson(json);

  @JsonKey(name: 'odata.metadata')
  final String odataMetadata;
  @JsonKey(name: 'BusStopCode')
  final String busStopCode;
  @JsonKey(name: 'Services')
  final List<BusArrivalServiceModel> services;

  Map<String, dynamic> toJson() => _$BusArrivalModelToJson(this);
}
