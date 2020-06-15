import 'package:json_annotation/json_annotation.dart';

import 'bus_arrival_service_model.dart';

part 'bus_arrival_service_list_model.g.dart';

@JsonSerializable()
class BusArrivalServiceListModel {
  BusArrivalServiceListModel({
    this.odataMetadata,
    this.busStopCode,
    this.services,
  });

  factory BusArrivalServiceListModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalServiceListModelFromJson(json);

  @JsonKey(name: 'odata.metadata')
  final String odataMetadata;
  @JsonKey(name: 'BusStopCode')
  final String busStopCode;
  @JsonKey(name: 'Services')
  final List<BusArrivalServiceModel> services;

  Map<String, dynamic> toJson() => _$BusArrivalServiceListModelToJson(this);
}
