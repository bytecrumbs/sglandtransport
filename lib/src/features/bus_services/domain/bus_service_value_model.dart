import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_service_value_model.freezed.dart';
part 'bus_service_value_model.g.dart';

@freezed
abstract class BusServiceValueModel with _$BusServiceValueModel {
  factory BusServiceValueModel({
    @JsonKey(name: 'ServiceNo') required String serviceNo,
    @JsonKey(name: 'Operator') required String busOperator,
    @JsonKey(name: 'Direction') required int direction,
    @JsonKey(name: 'Category') required String category,
    @JsonKey(name: 'OriginCode') required String originCode,
    @JsonKey(name: 'DestinationCode') required String destinationCode,
    @JsonKey(name: 'AM_Peak_Freq') required String amPeakFreq,
    @JsonKey(name: 'AM_Offpeak_Freq') required String amOffpeakFreq,
    @JsonKey(name: 'PM_Peak_Freq') required String pmPeakFreq,
    @JsonKey(name: 'PM_Offpeak_Freq') required String pmOffpeakFreq,
    @JsonKey(name: 'LoopDesc') String? loopDesc,
  }) = _BusServiceValueModel;

  /// Named constructor to convert from Json to a proper model
  factory BusServiceValueModel.fromJson(Map<String, dynamic> json) =>
      _$BusServiceValueModelFromJson(json);
}
