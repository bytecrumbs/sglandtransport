import 'package:freezed_annotation/freezed_annotation.dart';

import '../../bus_stops/domain/bus_stop_value_model.dart';
import 'bus_arrival_service_model.dart';

part 'bus_arrival_with_bus_stop_model.freezed.dart';

@freezed
class BusArrivalWithBusStopModel with _$BusArrivalWithBusStopModel {
  factory BusArrivalWithBusStopModel({
    required BusStopValueModel busStopValueModel,
    required List<BusArrivalServiceModel> services,
  }) = _BusArrivalWithBusStopModel;
}
