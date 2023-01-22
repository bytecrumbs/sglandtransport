import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_location_model.freezed.dart';

@freezed
class UserLocationModel with _$UserLocationModel {
  factory UserLocationModel({
    double? latitude,
    double? longitude,
  }) = _UserLocationModel;
}
