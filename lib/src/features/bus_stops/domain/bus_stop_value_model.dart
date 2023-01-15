import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_stop_value_model.freezed.dart';
part 'bus_stop_value_model.g.dart';

@freezed
class BusStopValueModel with _$BusStopValueModel {
  factory BusStopValueModel({
    @JsonKey(name: 'BusStopCode') String? busStopCode,
    @JsonKey(name: 'RoadName') String? roadName,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'Latitude') double? latitude,
    @JsonKey(name: 'Longitude') double? longitude,
    int? distanceInMeters,
  }) = _BusStopValueModel;

  /// Named constructor to convert from Json to a proper model
  factory BusStopValueModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopValueModelFromJson(json);
}
