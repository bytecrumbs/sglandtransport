import 'package:freezed_annotation/freezed_annotation.dart';

part 'next_bus_model.freezed.dart';
part 'next_bus_model.g.dart';

@freezed
class NextBusModel with _$NextBusModel {
  factory NextBusModel({
    @JsonKey(name: 'OriginCode') String? originCode,
    @JsonKey(name: 'DestinationCode') String? destinationCode,
    @JsonKey(name: 'EstimatedArrival') String? estimatedArrivalAbsolute,
    @JsonKey(name: 'Latitude') String? latitude,
    @JsonKey(name: 'Longitude') String? longitude,
    @JsonKey(name: 'VisitNumber') String? visitNumber,
    @JsonKey(name: 'Load') String? load,
    @JsonKey(name: 'Feature') String? feature,
    @JsonKey(name: 'Type') String? type,
  }) = _NextBusModel;

  NextBusModel._();

  factory NextBusModel.fromJson(Map<String, dynamic> json) =>
      _$NextBusModelFromJson(json);

  // All derived bus arrival duration should be rounded down to the nearest minute.
  String getEstimatedArrival() {
    if (estimatedArrivalAbsolute != null && estimatedArrivalAbsolute != '') {
      final arrivalDateTime = DateTime.parse(estimatedArrivalAbsolute!);
      // ignore milliseconds in the calculation
      final arrivalDateTimeTrimmed = DateTime(
        arrivalDateTime.year,
        arrivalDateTime.month,
        arrivalDateTime.day,
        arrivalDateTime.hour,
        arrivalDateTime.minute,
        arrivalDateTime.second,
      );
      final now = DateTime.now().toUtc();
      // ignore milliseconds in the calculation
      final nowTrimmed = DateTime(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
      );
      final arrivalInMinutes =
          arrivalDateTimeTrimmed.difference(nowTrimmed).inSeconds;
      if (arrivalInMinutes <= 59) {
        return 'Arr';
      } else {
        return '${arrivalInMinutes ~/ 60}min';
      }
    } else {
      return 'n/a';
    }
  }
}
