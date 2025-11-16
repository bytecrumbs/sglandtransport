import 'package:freezed_annotation/freezed_annotation.dart';

import 'bus_route_value_model.dart';

part 'bus_route_model.freezed.dart';
part 'bus_route_model.g.dart';

@freezed
abstract class BusRouteModel with _$BusRouteModel {
  factory BusRouteModel({
    @JsonKey(name: 'odata.metadata') required String odataMetadata,
    required List<BusRouteValueModel> value,
  }) = _BusRouteModel;

  /// Named constructor to convert from Json to a proper model
  factory BusRouteModel.fromJson(Map<String, dynamic> json) =>
      _$BusRouteModelFromJson(json);
}
