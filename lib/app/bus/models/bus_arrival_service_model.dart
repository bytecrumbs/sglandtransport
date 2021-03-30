import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'next_bus_model.dart';

part 'bus_arrival_service_model.freezed.dart';
part 'bus_arrival_service_model.g.dart';

@freezed

/// Freezed model of BusArrivalServiceModel
class BusArrivalServiceModel with _$BusArrivalServiceModel {
  /// Factory constructor for freezed model
  factory BusArrivalServiceModel({
    @JsonKey(name: 'ServiceNo') String? serviceNo,
    @JsonKey(name: 'Operator') String? busOperator,
    @JsonKey(name: 'NextBus') NextBusModel? nextBus,
    @JsonKey(name: 'NextBus2') NextBusModel? nextBus2,
    @JsonKey(name: 'NextBus3') NextBusModel? nextBus3,
    @Default(true) bool inService,
    String? destinationName,
  }) = _BusArrivalServiceModel;

  /// Named constructor to convert from Json to a proper model
  factory BusArrivalServiceModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalServiceModelFromJson(json);
}
