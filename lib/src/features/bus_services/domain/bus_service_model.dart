import 'package:freezed_annotation/freezed_annotation.dart';

import 'bus_service_value_model.dart';

part 'bus_service_model.freezed.dart';
part 'bus_service_model.g.dart';

@freezed
abstract class BusServiceModel with _$BusServiceModel {
  factory BusServiceModel({
    @JsonKey(name: 'odata.metadata') required String odataMetadata,
    required List<BusServiceValueModel> value,
  }) = _BusServiceModel;

  factory BusServiceModel.fromJson(Map<String, dynamic> json) =>
      _$BusServiceModelFromJson(json);
}
