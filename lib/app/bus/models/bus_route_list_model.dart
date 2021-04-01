import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'bus_route_model.dart';

part 'bus_route_list_model.freezed.dart';
part 'bus_route_list_model.g.dart';

@freezed

/// Freezed model of BusRouteListModel
class BusRouteListModel with _$BusRouteListModel {
  /// Factory constructor for freezed model
  factory BusRouteListModel({
    @JsonKey(name: 'odata.metadata') String? odataMetadata,
    List<BusRouteModel?>? value,
  }) = _BusRouteListModel;

  /// Named constructor to convert from Json to a proper model
  factory BusRouteListModel.fromJson(Map<String, dynamic> json) =>
      _$BusRouteListModelFromJson(json);
}
