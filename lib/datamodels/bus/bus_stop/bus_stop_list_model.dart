import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'bus_stop_model.dart';

part 'bus_stop_list_model.freezed.dart';
part 'bus_stop_list_model.g.dart';

@freezed
abstract class BusStopListModel with _$BusStopListModel {
  factory BusStopListModel({
    @JsonKey(name: 'odata.metadata') String odataMetadata,
    List<BusStopModel> value,
  }) = _BusStopListModel;

  factory BusStopListModel.fromJson(Map<String, dynamic> json) =>
      _$BusStopListModelFromJson(json);
}
