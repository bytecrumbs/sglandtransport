import 'package:freezed_annotation/freezed_annotation.dart';

import 'next_bus_model.dart';

part 'bus_arrival_service_model.freezed.dart';
part 'bus_arrival_service_model.g.dart';

@freezed
class BusArrivalServiceModel with _$BusArrivalServiceModel {
  factory BusArrivalServiceModel({
    @JsonKey(name: 'ServiceNo') required String serviceNo,
    @JsonKey(name: 'Operator') required String busOperator,
    @JsonKey(name: 'NextBus') required NextBusModel nextBus,
    @JsonKey(name: 'NextBus2') required NextBusModel nextBus2,
    @JsonKey(name: 'NextBus3') required NextBusModel nextBus3,
    @Default(true) bool inService,
    String? destinationName,
  }) = _BusArrivalServiceModel;

  /// Named constructor to convert from Json to a proper model
  factory BusArrivalServiceModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalServiceModelFromJson(json);
}
