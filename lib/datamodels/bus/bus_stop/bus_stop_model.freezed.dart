// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bus_stop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
BusStopModel _$BusStopModelFromJson(Map<String, dynamic> json) {
  return _BusStopModel.fromJson(json);
}

class _$BusStopModelTearOff {
  const _$BusStopModelTearOff();

// ignore: unused_element
  _BusStopModel call(
      {@JsonKey(name: 'BusStopCode') String busStopCode,
      @JsonKey(name: 'RoadName') String roadName,
      @JsonKey(name: 'Description') String description,
      @JsonKey(name: 'Latitude') double latitude,
      @JsonKey(name: 'Longitude') double longitude,
      int distanceInMeters}) {
    return _BusStopModel(
      busStopCode: busStopCode,
      roadName: roadName,
      description: description,
      latitude: latitude,
      longitude: longitude,
      distanceInMeters: distanceInMeters,
    );
  }
}

// ignore: unused_element
const $BusStopModel = _$BusStopModelTearOff();

mixin _$BusStopModel {
  @JsonKey(name: 'BusStopCode')
  String get busStopCode;
  @JsonKey(name: 'RoadName')
  String get roadName;
  @JsonKey(name: 'Description')
  String get description;
  @JsonKey(name: 'Latitude')
  double get latitude;
  @JsonKey(name: 'Longitude')
  double get longitude;
  int get distanceInMeters;

  Map<String, dynamic> toJson();
  $BusStopModelCopyWith<BusStopModel> get copyWith;
}

abstract class $BusStopModelCopyWith<$Res> {
  factory $BusStopModelCopyWith(
          BusStopModel value, $Res Function(BusStopModel) then) =
      _$BusStopModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'BusStopCode') String busStopCode,
      @JsonKey(name: 'RoadName') String roadName,
      @JsonKey(name: 'Description') String description,
      @JsonKey(name: 'Latitude') double latitude,
      @JsonKey(name: 'Longitude') double longitude,
      int distanceInMeters});
}

class _$BusStopModelCopyWithImpl<$Res> implements $BusStopModelCopyWith<$Res> {
  _$BusStopModelCopyWithImpl(this._value, this._then);

  final BusStopModel _value;
  // ignore: unused_field
  final $Res Function(BusStopModel) _then;

  @override
  $Res call({
    Object busStopCode = freezed,
    Object roadName = freezed,
    Object description = freezed,
    Object latitude = freezed,
    Object longitude = freezed,
    Object distanceInMeters = freezed,
  }) {
    return _then(_value.copyWith(
      busStopCode:
          busStopCode == freezed ? _value.busStopCode : busStopCode as String,
      roadName: roadName == freezed ? _value.roadName : roadName as String,
      description:
          description == freezed ? _value.description : description as String,
      latitude: latitude == freezed ? _value.latitude : latitude as double,
      longitude: longitude == freezed ? _value.longitude : longitude as double,
      distanceInMeters: distanceInMeters == freezed
          ? _value.distanceInMeters
          : distanceInMeters as int,
    ));
  }
}

abstract class _$BusStopModelCopyWith<$Res>
    implements $BusStopModelCopyWith<$Res> {
  factory _$BusStopModelCopyWith(
          _BusStopModel value, $Res Function(_BusStopModel) then) =
      __$BusStopModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'BusStopCode') String busStopCode,
      @JsonKey(name: 'RoadName') String roadName,
      @JsonKey(name: 'Description') String description,
      @JsonKey(name: 'Latitude') double latitude,
      @JsonKey(name: 'Longitude') double longitude,
      int distanceInMeters});
}

class __$BusStopModelCopyWithImpl<$Res> extends _$BusStopModelCopyWithImpl<$Res>
    implements _$BusStopModelCopyWith<$Res> {
  __$BusStopModelCopyWithImpl(
      _BusStopModel _value, $Res Function(_BusStopModel) _then)
      : super(_value, (v) => _then(v as _BusStopModel));

  @override
  _BusStopModel get _value => super._value as _BusStopModel;

  @override
  $Res call({
    Object busStopCode = freezed,
    Object roadName = freezed,
    Object description = freezed,
    Object latitude = freezed,
    Object longitude = freezed,
    Object distanceInMeters = freezed,
  }) {
    return _then(_BusStopModel(
      busStopCode:
          busStopCode == freezed ? _value.busStopCode : busStopCode as String,
      roadName: roadName == freezed ? _value.roadName : roadName as String,
      description:
          description == freezed ? _value.description : description as String,
      latitude: latitude == freezed ? _value.latitude : latitude as double,
      longitude: longitude == freezed ? _value.longitude : longitude as double,
      distanceInMeters: distanceInMeters == freezed
          ? _value.distanceInMeters
          : distanceInMeters as int,
    ));
  }
}

@JsonSerializable()
class _$_BusStopModel with DiagnosticableTreeMixin implements _BusStopModel {
  _$_BusStopModel(
      {@JsonKey(name: 'BusStopCode') this.busStopCode,
      @JsonKey(name: 'RoadName') this.roadName,
      @JsonKey(name: 'Description') this.description,
      @JsonKey(name: 'Latitude') this.latitude,
      @JsonKey(name: 'Longitude') this.longitude,
      this.distanceInMeters});

  factory _$_BusStopModel.fromJson(Map<String, dynamic> json) =>
      _$_$_BusStopModelFromJson(json);

  @override
  @JsonKey(name: 'BusStopCode')
  final String busStopCode;
  @override
  @JsonKey(name: 'RoadName')
  final String roadName;
  @override
  @JsonKey(name: 'Description')
  final String description;
  @override
  @JsonKey(name: 'Latitude')
  final double latitude;
  @override
  @JsonKey(name: 'Longitude')
  final double longitude;
  @override
  final int distanceInMeters;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BusStopModel(busStopCode: $busStopCode, roadName: $roadName, description: $description, latitude: $latitude, longitude: $longitude, distanceInMeters: $distanceInMeters)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BusStopModel'))
      ..add(DiagnosticsProperty('busStopCode', busStopCode))
      ..add(DiagnosticsProperty('roadName', roadName))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('distanceInMeters', distanceInMeters));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusStopModel &&
            (identical(other.busStopCode, busStopCode) ||
                const DeepCollectionEquality()
                    .equals(other.busStopCode, busStopCode)) &&
            (identical(other.roadName, roadName) ||
                const DeepCollectionEquality()
                    .equals(other.roadName, roadName)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.latitude, latitude) ||
                const DeepCollectionEquality()
                    .equals(other.latitude, latitude)) &&
            (identical(other.longitude, longitude) ||
                const DeepCollectionEquality()
                    .equals(other.longitude, longitude)) &&
            (identical(other.distanceInMeters, distanceInMeters) ||
                const DeepCollectionEquality()
                    .equals(other.distanceInMeters, distanceInMeters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(busStopCode) ^
      const DeepCollectionEquality().hash(roadName) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(latitude) ^
      const DeepCollectionEquality().hash(longitude) ^
      const DeepCollectionEquality().hash(distanceInMeters);

  @override
  _$BusStopModelCopyWith<_BusStopModel> get copyWith =>
      __$BusStopModelCopyWithImpl<_BusStopModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BusStopModelToJson(this);
  }
}

abstract class _BusStopModel implements BusStopModel {
  factory _BusStopModel(
      {@JsonKey(name: 'BusStopCode') String busStopCode,
      @JsonKey(name: 'RoadName') String roadName,
      @JsonKey(name: 'Description') String description,
      @JsonKey(name: 'Latitude') double latitude,
      @JsonKey(name: 'Longitude') double longitude,
      int distanceInMeters}) = _$_BusStopModel;

  factory _BusStopModel.fromJson(Map<String, dynamic> json) =
      _$_BusStopModel.fromJson;

  @override
  @JsonKey(name: 'BusStopCode')
  String get busStopCode;
  @override
  @JsonKey(name: 'RoadName')
  String get roadName;
  @override
  @JsonKey(name: 'Description')
  String get description;
  @override
  @JsonKey(name: 'Latitude')
  double get latitude;
  @override
  @JsonKey(name: 'Longitude')
  double get longitude;
  @override
  int get distanceInMeters;
  @override
  _$BusStopModelCopyWith<_BusStopModel> get copyWith;
}
