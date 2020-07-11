import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'bus_arrival_service_model.dart';

part 'bus_arrival_service_list_model.freezed.dart';
part 'bus_arrival_service_list_model.g.dart';

@freezed
abstract class BusArrivalServiceListModel with _$BusArrivalServiceListModel {
  factory BusArrivalServiceListModel({
    @JsonKey(name: 'odata.metadata') String odataMetadata,
    @JsonKey(name: 'BusStopCode') String busStopCode,
    @JsonKey(name: 'Services') List<BusArrivalServiceModel> services,
  }) = _BusArrivalServiceListModel;

  factory BusArrivalServiceListModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalServiceListModelFromJson(json);
}
