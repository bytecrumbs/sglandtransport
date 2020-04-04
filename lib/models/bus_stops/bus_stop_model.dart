import 'package:json_annotation/json_annotation.dart';

part 'bus_stop_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class BusStopModel {
  BusStopModel(
    this.busStopCode,
    this.roadName,
    this.description,
    this.latitude,
    this.longitude,
  );

  factory BusStopModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopModelFromJson(json);

  @JsonKey(name: 'BusStopCode')
  final String busStopCode;
  @JsonKey(name: 'RoadName')
  final String roadName;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'Latitude')
  final double latitude;
  @JsonKey(name: 'Longitude')
  final double longitude;

  Map<String, dynamic> toJson() => _$BusStopModelToJson(this);
}
