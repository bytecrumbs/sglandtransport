import 'package:json_annotation/json_annotation.dart';

import 'bus_stop_model.dart';

part 'bus_stop_list_model.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class BusStopListModel {
  BusStopListModel(
    this.odataMetadata,
    this.value,
  );

  factory BusStopListModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopListModelFromJson(json);

  @JsonKey(name: 'odata.metadata')
  final String odataMetadata;
  final List<BusStopModel> value;

  Map<String, dynamic> toJson() => _$BusStopListModelToJson(this);
}
