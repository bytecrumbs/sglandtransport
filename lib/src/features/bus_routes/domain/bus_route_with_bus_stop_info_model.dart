import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_route_with_bus_stop_info_model.freezed.dart';

@freezed
abstract class BusRouteWithBusStopInfoModel
    with _$BusRouteWithBusStopInfoModel {
  factory BusRouteWithBusStopInfoModel({
    @JsonKey(name: 'ServiceNo') required String serviceNo,
    @JsonKey(name: 'Direction') required int direction,
    @JsonKey(name: 'StopSequence') required int stopSequence,
    @JsonKey(name: 'BusStopCode') required String busStopCode,
    @JsonKey(name: 'Distance') required double distance,
    @JsonKey(name: 'RoadName') required String roadName,
    @JsonKey(name: 'Description') required String description,
    @JsonKey(name: 'Latitude') required double latitude,
    @JsonKey(name: 'Longitude') required double longitude,
    @Default(false) bool isPreviousStops,
  }) = _BusRouteWithBusStopInfoModel;
}
