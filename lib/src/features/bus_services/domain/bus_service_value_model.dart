import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_service_value_model.freezed.dart';
part 'bus_service_value_model.g.dart';

// TODO: do we really need to keep them as nullable? Check the API.
@freezed
class BusServiceValueModel with _$BusServiceValueModel {
  factory BusServiceValueModel({
    @JsonKey(name: 'ServiceNo') String? serviceNo,
    @JsonKey(name: 'Operator') String? busOperator,
    @JsonKey(name: 'Direction') int? direction,
    @JsonKey(name: 'Category') String? category,
    @JsonKey(name: 'OriginCode') String? originCode,
    @JsonKey(name: 'DestinationCode') String? destinationCode,
    @JsonKey(name: 'AM_Peak_Freq') String? amPeakFreq,
    @JsonKey(name: 'AM_Offpeak_Freq') String? amOffpeakFreq,
    @JsonKey(name: 'PM_Peak_Freq') String? pmPeakFreq,
    @JsonKey(name: 'PM_Offpeak_Freq') String? pmOffpeakFreq,
    @JsonKey(name: 'LoopDesc') String? loopDesc,
  }) = _BusServiceValueModel;

  /// Named constructor to convert from Json to a proper model
  factory BusServiceValueModel.fromJson(Map<String, dynamic> json) =>
      _$BusServiceValueModelFromJson(json);
}
