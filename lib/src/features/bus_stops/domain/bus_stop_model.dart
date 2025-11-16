import 'package:freezed_annotation/freezed_annotation.dart';

import 'bus_stop_value_model.dart';

part 'bus_stop_model.freezed.dart';
part 'bus_stop_model.g.dart';

@freezed
abstract class BusStopModel with _$BusStopModel {
  factory BusStopModel({
    @JsonKey(name: 'odata.metadata') required String odataMetadata,
    required List<BusStopValueModel> value,
  }) = _BusStopModel;

  /// Named constructor to convert from Json to a proper model
  factory BusStopModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopModelFromJson(json);
}
