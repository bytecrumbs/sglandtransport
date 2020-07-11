import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'bus_route_model.dart';

part 'bus_route_list_model.freezed.dart';
part 'bus_route_list_model.g.dart';

@freezed
abstract class BusRouteListModel with _$BusRouteListModel {
  factory BusRouteListModel({
    @JsonKey(name: 'odata.metadata') String odataMetadata,
    List<BusRouteModel> value,
  }) = _BusRouteListModel;

  factory BusRouteListModel.fromJson(Map<String, dynamic> json) =>
      _$BusRouteListModelFromJson(json);
}
