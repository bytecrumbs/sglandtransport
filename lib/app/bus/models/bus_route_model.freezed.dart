// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'bus_route_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusRouteModel _$BusRouteModelFromJson(Map<String, dynamic> json) {
  return _BusRouteModel.fromJson(json);
}

/// @nodoc
class _$BusRouteModelTearOff {
  const _$BusRouteModelTearOff();

  _BusRouteModel call(
      {@JsonKey(name: 'ServiceNo') required String serviceNo,
      @JsonKey(name: 'Operator') required String busOperator,
      @JsonKey(name: 'Direction') required int direction,
      @JsonKey(name: 'StopSequence') required int stopSequence,
      @JsonKey(name: 'BusStopCode') required String busStopCode,
      @JsonKey(name: 'Distance') required double distance,
      @JsonKey(name: 'WD_FirstBus') required String wdFirstBus,
      @JsonKey(name: 'WD_LastBus') required String wdLastBus,
      @JsonKey(name: 'SAT_FirstBus') required String satFirstBus,
      @JsonKey(name: 'SAT_LastBus') required String satLastBus,
      @JsonKey(name: 'SUN_FirstBus') required String sunFirstBus,
      @JsonKey(name: 'SUN_LastBus') required String sunLastBus}) {
    return _BusRouteModel(
      serviceNo: serviceNo,
      busOperator: busOperator,
      direction: direction,
      stopSequence: stopSequence,
      busStopCode: busStopCode,
      distance: distance,
      wdFirstBus: wdFirstBus,
      wdLastBus: wdLastBus,
      satFirstBus: satFirstBus,
      satLastBus: satLastBus,
      sunFirstBus: sunFirstBus,
      sunLastBus: sunLastBus,
    );
  }

  BusRouteModel fromJson(Map<String, Object> json) {
    return BusRouteModel.fromJson(json);
  }
}

/// @nodoc
const $BusRouteModel = _$BusRouteModelTearOff();

/// @nodoc
mixin _$BusRouteModel {
  @JsonKey(name: 'ServiceNo')
  String get serviceNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'Operator')
  String get busOperator => throw _privateConstructorUsedError;
  @JsonKey(name: 'Direction')
  int get direction => throw _privateConstructorUsedError;
  @JsonKey(name: 'StopSequence')
  int get stopSequence => throw _privateConstructorUsedError;
  @JsonKey(name: 'BusStopCode')
  String get busStopCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'Distance')
  double get distance => throw _privateConstructorUsedError;
  @JsonKey(name: 'WD_FirstBus')
  String get wdFirstBus => throw _privateConstructorUsedError;
  @JsonKey(name: 'WD_LastBus')
  String get wdLastBus => throw _privateConstructorUsedError;
  @JsonKey(name: 'SAT_FirstBus')
  String get satFirstBus => throw _privateConstructorUsedError;
  @JsonKey(name: 'SAT_LastBus')
  String get satLastBus => throw _privateConstructorUsedError;
  @JsonKey(name: 'SUN_FirstBus')
  String get sunFirstBus => throw _privateConstructorUsedError;
  @JsonKey(name: 'SUN_LastBus')
  String get sunLastBus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusRouteModelCopyWith<BusRouteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusRouteModelCopyWith<$Res> {
  factory $BusRouteModelCopyWith(
          BusRouteModel value, $Res Function(BusRouteModel) then) =
      _$BusRouteModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'ServiceNo') String serviceNo,
      @JsonKey(name: 'Operator') String busOperator,
      @JsonKey(name: 'Direction') int direction,
      @JsonKey(name: 'StopSequence') int stopSequence,
      @JsonKey(name: 'BusStopCode') String busStopCode,
      @JsonKey(name: 'Distance') double distance,
      @JsonKey(name: 'WD_FirstBus') String wdFirstBus,
      @JsonKey(name: 'WD_LastBus') String wdLastBus,
      @JsonKey(name: 'SAT_FirstBus') String satFirstBus,
      @JsonKey(name: 'SAT_LastBus') String satLastBus,
      @JsonKey(name: 'SUN_FirstBus') String sunFirstBus,
      @JsonKey(name: 'SUN_LastBus') String sunLastBus});
}

/// @nodoc
class _$BusRouteModelCopyWithImpl<$Res>
    implements $BusRouteModelCopyWith<$Res> {
  _$BusRouteModelCopyWithImpl(this._value, this._then);

  final BusRouteModel _value;
  // ignore: unused_field
  final $Res Function(BusRouteModel) _then;

  @override
  $Res call({
    Object? serviceNo = freezed,
    Object? busOperator = freezed,
    Object? direction = freezed,
    Object? stopSequence = freezed,
    Object? busStopCode = freezed,
    Object? distance = freezed,
    Object? wdFirstBus = freezed,
    Object? wdLastBus = freezed,
    Object? satFirstBus = freezed,
    Object? satLastBus = freezed,
    Object? sunFirstBus = freezed,
    Object? sunLastBus = freezed,
  }) {
    return _then(_value.copyWith(
      serviceNo: serviceNo == freezed
          ? _value.serviceNo
          : serviceNo // ignore: cast_nullable_to_non_nullable
              as String,
      busOperator: busOperator == freezed
          ? _value.busOperator
          : busOperator // ignore: cast_nullable_to_non_nullable
              as String,
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as int,
      stopSequence: stopSequence == freezed
          ? _value.stopSequence
          : stopSequence // ignore: cast_nullable_to_non_nullable
              as int,
      busStopCode: busStopCode == freezed
          ? _value.busStopCode
          : busStopCode // ignore: cast_nullable_to_non_nullable
              as String,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      wdFirstBus: wdFirstBus == freezed
          ? _value.wdFirstBus
          : wdFirstBus // ignore: cast_nullable_to_non_nullable
              as String,
      wdLastBus: wdLastBus == freezed
          ? _value.wdLastBus
          : wdLastBus // ignore: cast_nullable_to_non_nullable
              as String,
      satFirstBus: satFirstBus == freezed
          ? _value.satFirstBus
          : satFirstBus // ignore: cast_nullable_to_non_nullable
              as String,
      satLastBus: satLastBus == freezed
          ? _value.satLastBus
          : satLastBus // ignore: cast_nullable_to_non_nullable
              as String,
      sunFirstBus: sunFirstBus == freezed
          ? _value.sunFirstBus
          : sunFirstBus // ignore: cast_nullable_to_non_nullable
              as String,
      sunLastBus: sunLastBus == freezed
          ? _value.sunLastBus
          : sunLastBus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BusRouteModelCopyWith<$Res>
    implements $BusRouteModelCopyWith<$Res> {
  factory _$BusRouteModelCopyWith(
          _BusRouteModel value, $Res Function(_BusRouteModel) then) =
      __$BusRouteModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'ServiceNo') String serviceNo,
      @JsonKey(name: 'Operator') String busOperator,
      @JsonKey(name: 'Direction') int direction,
      @JsonKey(name: 'StopSequence') int stopSequence,
      @JsonKey(name: 'BusStopCode') String busStopCode,
      @JsonKey(name: 'Distance') double distance,
      @JsonKey(name: 'WD_FirstBus') String wdFirstBus,
      @JsonKey(name: 'WD_LastBus') String wdLastBus,
      @JsonKey(name: 'SAT_FirstBus') String satFirstBus,
      @JsonKey(name: 'SAT_LastBus') String satLastBus,
      @JsonKey(name: 'SUN_FirstBus') String sunFirstBus,
      @JsonKey(name: 'SUN_LastBus') String sunLastBus});
}

/// @nodoc
class __$BusRouteModelCopyWithImpl<$Res>
    extends _$BusRouteModelCopyWithImpl<$Res>
    implements _$BusRouteModelCopyWith<$Res> {
  __$BusRouteModelCopyWithImpl(
      _BusRouteModel _value, $Res Function(_BusRouteModel) _then)
      : super(_value, (v) => _then(v as _BusRouteModel));

  @override
  _BusRouteModel get _value => super._value as _BusRouteModel;

  @override
  $Res call({
    Object? serviceNo = freezed,
    Object? busOperator = freezed,
    Object? direction = freezed,
    Object? stopSequence = freezed,
    Object? busStopCode = freezed,
    Object? distance = freezed,
    Object? wdFirstBus = freezed,
    Object? wdLastBus = freezed,
    Object? satFirstBus = freezed,
    Object? satLastBus = freezed,
    Object? sunFirstBus = freezed,
    Object? sunLastBus = freezed,
  }) {
    return _then(_BusRouteModel(
      serviceNo: serviceNo == freezed
          ? _value.serviceNo
          : serviceNo // ignore: cast_nullable_to_non_nullable
              as String,
      busOperator: busOperator == freezed
          ? _value.busOperator
          : busOperator // ignore: cast_nullable_to_non_nullable
              as String,
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as int,
      stopSequence: stopSequence == freezed
          ? _value.stopSequence
          : stopSequence // ignore: cast_nullable_to_non_nullable
              as int,
      busStopCode: busStopCode == freezed
          ? _value.busStopCode
          : busStopCode // ignore: cast_nullable_to_non_nullable
              as String,
      distance: distance == freezed
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      wdFirstBus: wdFirstBus == freezed
          ? _value.wdFirstBus
          : wdFirstBus // ignore: cast_nullable_to_non_nullable
              as String,
      wdLastBus: wdLastBus == freezed
          ? _value.wdLastBus
          : wdLastBus // ignore: cast_nullable_to_non_nullable
              as String,
      satFirstBus: satFirstBus == freezed
          ? _value.satFirstBus
          : satFirstBus // ignore: cast_nullable_to_non_nullable
              as String,
      satLastBus: satLastBus == freezed
          ? _value.satLastBus
          : satLastBus // ignore: cast_nullable_to_non_nullable
              as String,
      sunFirstBus: sunFirstBus == freezed
          ? _value.sunFirstBus
          : sunFirstBus // ignore: cast_nullable_to_non_nullable
              as String,
      sunLastBus: sunLastBus == freezed
          ? _value.sunLastBus
          : sunLastBus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_BusRouteModel with DiagnosticableTreeMixin implements _BusRouteModel {
  _$_BusRouteModel(
      {@JsonKey(name: 'ServiceNo') required this.serviceNo,
      @JsonKey(name: 'Operator') required this.busOperator,
      @JsonKey(name: 'Direction') required this.direction,
      @JsonKey(name: 'StopSequence') required this.stopSequence,
      @JsonKey(name: 'BusStopCode') required this.busStopCode,
      @JsonKey(name: 'Distance') required this.distance,
      @JsonKey(name: 'WD_FirstBus') required this.wdFirstBus,
      @JsonKey(name: 'WD_LastBus') required this.wdLastBus,
      @JsonKey(name: 'SAT_FirstBus') required this.satFirstBus,
      @JsonKey(name: 'SAT_LastBus') required this.satLastBus,
      @JsonKey(name: 'SUN_FirstBus') required this.sunFirstBus,
      @JsonKey(name: 'SUN_LastBus') required this.sunLastBus});

  factory _$_BusRouteModel.fromJson(Map<String, dynamic> json) =>
      _$_$_BusRouteModelFromJson(json);

  @override
  @JsonKey(name: 'ServiceNo')
  final String serviceNo;
  @override
  @JsonKey(name: 'Operator')
  final String busOperator;
  @override
  @JsonKey(name: 'Direction')
  final int direction;
  @override
  @JsonKey(name: 'StopSequence')
  final int stopSequence;
  @override
  @JsonKey(name: 'BusStopCode')
  final String busStopCode;
  @override
  @JsonKey(name: 'Distance')
  final double distance;
  @override
  @JsonKey(name: 'WD_FirstBus')
  final String wdFirstBus;
  @override
  @JsonKey(name: 'WD_LastBus')
  final String wdLastBus;
  @override
  @JsonKey(name: 'SAT_FirstBus')
  final String satFirstBus;
  @override
  @JsonKey(name: 'SAT_LastBus')
  final String satLastBus;
  @override
  @JsonKey(name: 'SUN_FirstBus')
  final String sunFirstBus;
  @override
  @JsonKey(name: 'SUN_LastBus')
  final String sunLastBus;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BusRouteModel(serviceNo: $serviceNo, busOperator: $busOperator, direction: $direction, stopSequence: $stopSequence, busStopCode: $busStopCode, distance: $distance, wdFirstBus: $wdFirstBus, wdLastBus: $wdLastBus, satFirstBus: $satFirstBus, satLastBus: $satLastBus, sunFirstBus: $sunFirstBus, sunLastBus: $sunLastBus)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BusRouteModel'))
      ..add(DiagnosticsProperty('serviceNo', serviceNo))
      ..add(DiagnosticsProperty('busOperator', busOperator))
      ..add(DiagnosticsProperty('direction', direction))
      ..add(DiagnosticsProperty('stopSequence', stopSequence))
      ..add(DiagnosticsProperty('busStopCode', busStopCode))
      ..add(DiagnosticsProperty('distance', distance))
      ..add(DiagnosticsProperty('wdFirstBus', wdFirstBus))
      ..add(DiagnosticsProperty('wdLastBus', wdLastBus))
      ..add(DiagnosticsProperty('satFirstBus', satFirstBus))
      ..add(DiagnosticsProperty('satLastBus', satLastBus))
      ..add(DiagnosticsProperty('sunFirstBus', sunFirstBus))
      ..add(DiagnosticsProperty('sunLastBus', sunLastBus));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusRouteModel &&
            (identical(other.serviceNo, serviceNo) ||
                const DeepCollectionEquality()
                    .equals(other.serviceNo, serviceNo)) &&
            (identical(other.busOperator, busOperator) ||
                const DeepCollectionEquality()
                    .equals(other.busOperator, busOperator)) &&
            (identical(other.direction, direction) ||
                const DeepCollectionEquality()
                    .equals(other.direction, direction)) &&
            (identical(other.stopSequence, stopSequence) ||
                const DeepCollectionEquality()
                    .equals(other.stopSequence, stopSequence)) &&
            (identical(other.busStopCode, busStopCode) ||
                const DeepCollectionEquality()
                    .equals(other.busStopCode, busStopCode)) &&
            (identical(other.distance, distance) ||
                const DeepCollectionEquality()
                    .equals(other.distance, distance)) &&
            (identical(other.wdFirstBus, wdFirstBus) ||
                const DeepCollectionEquality()
                    .equals(other.wdFirstBus, wdFirstBus)) &&
            (identical(other.wdLastBus, wdLastBus) ||
                const DeepCollectionEquality()
                    .equals(other.wdLastBus, wdLastBus)) &&
            (identical(other.satFirstBus, satFirstBus) ||
                const DeepCollectionEquality()
                    .equals(other.satFirstBus, satFirstBus)) &&
            (identical(other.satLastBus, satLastBus) ||
                const DeepCollectionEquality()
                    .equals(other.satLastBus, satLastBus)) &&
            (identical(other.sunFirstBus, sunFirstBus) ||
                const DeepCollectionEquality()
                    .equals(other.sunFirstBus, sunFirstBus)) &&
            (identical(other.sunLastBus, sunLastBus) ||
                const DeepCollectionEquality()
                    .equals(other.sunLastBus, sunLastBus)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(serviceNo) ^
      const DeepCollectionEquality().hash(busOperator) ^
      const DeepCollectionEquality().hash(direction) ^
      const DeepCollectionEquality().hash(stopSequence) ^
      const DeepCollectionEquality().hash(busStopCode) ^
      const DeepCollectionEquality().hash(distance) ^
      const DeepCollectionEquality().hash(wdFirstBus) ^
      const DeepCollectionEquality().hash(wdLastBus) ^
      const DeepCollectionEquality().hash(satFirstBus) ^
      const DeepCollectionEquality().hash(satLastBus) ^
      const DeepCollectionEquality().hash(sunFirstBus) ^
      const DeepCollectionEquality().hash(sunLastBus);

  @JsonKey(ignore: true)
  @override
  _$BusRouteModelCopyWith<_BusRouteModel> get copyWith =>
      __$BusRouteModelCopyWithImpl<_BusRouteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BusRouteModelToJson(this);
  }
}

abstract class _BusRouteModel implements BusRouteModel {
  factory _BusRouteModel(
          {@JsonKey(name: 'ServiceNo') required String serviceNo,
          @JsonKey(name: 'Operator') required String busOperator,
          @JsonKey(name: 'Direction') required int direction,
          @JsonKey(name: 'StopSequence') required int stopSequence,
          @JsonKey(name: 'BusStopCode') required String busStopCode,
          @JsonKey(name: 'Distance') required double distance,
          @JsonKey(name: 'WD_FirstBus') required String wdFirstBus,
          @JsonKey(name: 'WD_LastBus') required String wdLastBus,
          @JsonKey(name: 'SAT_FirstBus') required String satFirstBus,
          @JsonKey(name: 'SAT_LastBus') required String satLastBus,
          @JsonKey(name: 'SUN_FirstBus') required String sunFirstBus,
          @JsonKey(name: 'SUN_LastBus') required String sunLastBus}) =
      _$_BusRouteModel;

  factory _BusRouteModel.fromJson(Map<String, dynamic> json) =
      _$_BusRouteModel.fromJson;

  @override
  @JsonKey(name: 'ServiceNo')
  String get serviceNo => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'Operator')
  String get busOperator => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'Direction')
  int get direction => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'StopSequence')
  int get stopSequence => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'BusStopCode')
  String get busStopCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'Distance')
  double get distance => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'WD_FirstBus')
  String get wdFirstBus => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'WD_LastBus')
  String get wdLastBus => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'SAT_FirstBus')
  String get satFirstBus => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'SAT_LastBus')
  String get satLastBus => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'SUN_FirstBus')
  String get sunFirstBus => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'SUN_LastBus')
  String get sunLastBus => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BusRouteModelCopyWith<_BusRouteModel> get copyWith =>
      throw _privateConstructorUsedError;
}
