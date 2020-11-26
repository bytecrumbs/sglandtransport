import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'bus_stop_model.freezed.dart';
part 'bus_stop_model.g.dart';

@freezed

/// Freezed model of BusStopListModel
abstract class BusStopModel with _$BusStopModel {
  /// Factory constructor for freezed model
  factory BusStopModel({
    @JsonKey(name: 'BusStopCode') String busStopCode,
    @JsonKey(name: 'RoadName') String roadName,
    @JsonKey(name: 'Description') String description,
    @JsonKey(name: 'Latitude') double latitude,
    @JsonKey(name: 'Longitude') double longitude,
    int distanceInMeters,
  }) = _BusStopModel;

  /// Named constructor to convert from Json to a proper model
  factory BusStopModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopModelFromJson(json);
}
