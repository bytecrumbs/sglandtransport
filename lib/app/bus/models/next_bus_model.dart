import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'next_bus_model.freezed.dart';
part 'next_bus_model.g.dart';

@freezed

/// Freezed model of BusArrivalServiceModel
class NextBusModel with _$NextBusModel {
  /// Factory constructor for freezed model
  factory NextBusModel({
    @JsonKey(name: 'OriginCode') String? originCode,
    @JsonKey(name: 'DestinationCode') String? destinationCode,
    @JsonKey(name: 'EstimatedArrival') String? estimatedArrival,
    @JsonKey(name: 'Latitude') String? latitude,
    @JsonKey(name: 'Longitude') String? longitude,
    @JsonKey(name: 'VisitNumber') String? visitNumber,
    @JsonKey(name: 'Load') String? load,
    @JsonKey(name: 'Feature') String? feature,
    @JsonKey(name: 'Type') String? type,
  }) = _NextBusModel;

  /// Named constructor to convert from Json to a proper model
  factory NextBusModel.fromJson(Map<String, dynamic> json) =>
      _$NextBusModelFromJson(json);
}
