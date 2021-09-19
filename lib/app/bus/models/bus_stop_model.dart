import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_stop_model.freezed.dart';
part 'bus_stop_model.g.dart';

@freezed

/// Freezed model of BusStopListModel
class BusStopModel with _$BusStopModel {
  /// Factory constructor for freezed model
  factory BusStopModel({
    @JsonKey(name: 'BusStopCode') required String busStopCode,
    @JsonKey(name: 'RoadName') required String roadName,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'Latitude') required double latitude,
    @JsonKey(name: 'Longitude') required double longitude,
    int? distanceInMeters,
  }) = _BusStopModel;

  /// Named constructor to convert from Json to a proper model
  factory BusStopModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopModelFromJson(json);
}
