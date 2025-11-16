import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_stop_value_model.freezed.dart';
part 'bus_stop_value_model.g.dart';

@freezed
abstract class BusStopValueModel with _$BusStopValueModel {
  factory BusStopValueModel({
    @JsonKey(name: 'BusStopCode') required String busStopCode,
    @JsonKey(name: 'RoadName') required String roadName,
    @JsonKey(name: 'Description') required String description,
    @JsonKey(name: 'Latitude') required double latitude,
    @JsonKey(name: 'Longitude') required double longitude,
    int? distanceInMeters,
  }) = _BusStopValueModel;

  /// Named constructor to convert from Json to a proper model
  factory BusStopValueModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopValueModelFromJson(json);
}
