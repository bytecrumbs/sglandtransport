import 'package:json_annotation/json_annotation.dart';

part 'next_bus_model.g.dart';

@JsonSerializable()
class NextBusModel {
  NextBusModel({
    this.originCode,
    this.destinationCode,
    this.estimatedArrival,
    this.latitude,
    this.longitude,
    this.visitNumber,
    this.load,
    this.feature,
    this.type,
  });

  factory NextBusModel.fromJson(Map<String, dynamic> json) =>
      _$NextBusModelFromJson(json);

  @JsonKey(name: 'OriginCode')
  final String originCode;
  @JsonKey(name: 'DestinationCode')
  final String destinationCode;
  @JsonKey(name: 'EstimatedArrival')
  final String estimatedArrival;
  @JsonKey(name: 'Latitude')
  final String latitude;
  @JsonKey(name: 'Longitude')
  final String longitude;
  @JsonKey(name: 'VisitNumber')
  final String visitNumber;
  @JsonKey(name: 'Load')
  final String load;
  @JsonKey(name: 'Feature')
  final String feature;
  @JsonKey(name: 'Type')
  final String type;

  Map<String, dynamic> toJson() => _$NextBusModelToJson(this);
}
