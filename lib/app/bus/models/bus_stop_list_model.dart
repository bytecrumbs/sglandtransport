import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'bus_stop_model.dart';

part 'bus_stop_list_model.freezed.dart';
part 'bus_stop_list_model.g.dart';

@freezed

/// Freezed model of BusStopListModel
class BusStopListModel with _$BusStopListModel {
  /// Factory constructor for freezed model
  factory BusStopListModel({
    @JsonKey(name: 'odata.metadata') required String odataMetadata,
    required List<BusStopModel> value,
  }) = _BusStopListModel;

  /// Named constructor to convert from Json to a proper model
  factory BusStopListModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopListModelFromJson(json);
}
