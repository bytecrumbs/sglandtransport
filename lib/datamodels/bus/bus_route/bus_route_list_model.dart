import 'package:json_annotation/json_annotation.dart';

import 'bus_route_model.dart';

part 'bus_route_list_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class BusRouteListModel {
  BusRouteListModel(
    this.odataMetadata,
    this.value,
  );

  factory BusRouteListModel.fromJson(Map<String, dynamic> json) =>
      _$BusRouteListModelFromJson(json);

  @JsonKey(name: 'odata.metadata')
  final String odataMetadata;
  final List<BusRouteModel> value;

  Map<String, dynamic> toJson() => _$BusRouteListModelToJson(this);
}
