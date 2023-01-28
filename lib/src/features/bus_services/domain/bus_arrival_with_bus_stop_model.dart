import 'package:freezed_annotation/freezed_annotation.dart';

import '../../bus_stops/data/bus_local_repository.dart';
import 'bus_arrival_service_model.dart';

part 'bus_arrival_with_bus_stop_model.freezed.dart';

@freezed
class BusArrivalWithBusStopModel with _$BusArrivalWithBusStopModel {
  factory BusArrivalWithBusStopModel({
    required TableBusStop tableBusStop,
    required List<BusArrivalServiceModel> services,
  }) = _BusArrivalWithBusStopModel;
}
