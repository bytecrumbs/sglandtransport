import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'bus_arrival_service_model.dart';

part 'bus_arrival_service_list_model.freezed.dart';
part 'bus_arrival_service_list_model.g.dart';

@freezed

/// Freezed model of BusArrivalServiceListModel
abstract class BusArrivalServiceListModel with _$BusArrivalServiceListModel {
  /// Factory constructor for freezed model
  factory BusArrivalServiceListModel({
    @JsonKey(name: 'odata.metadata') String odataMetadata,
    @JsonKey(name: 'BusStopCode') String busStopCode,
    @JsonKey(name: 'Services') List<BusArrivalServiceModel> services,
  }) = _BusArrivalServiceListModel;

  /// Named constructor to convert from Json to a proper model
  factory BusArrivalServiceListModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalServiceListModelFromJson(json);
}
