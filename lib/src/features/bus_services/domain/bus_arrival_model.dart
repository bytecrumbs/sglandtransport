import 'package:freezed_annotation/freezed_annotation.dart';

import 'bus_arrival_service_model.dart';

part 'bus_arrival_model.freezed.dart';
part 'bus_arrival_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class BusArrivalModel with _$BusArrivalModel {
  factory BusArrivalModel({
    @JsonKey(name: 'odata.metadata') required String odataMetadata,
    @JsonKey(name: 'BusStopCode') required String busStopCode,
    @JsonKey(name: 'Services') required List<BusArrivalServiceModel> services,
    String? roadName,
    String? description,
  }) = _BusArrivalModel;

  factory BusArrivalModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalModelFromJson(json);
}
