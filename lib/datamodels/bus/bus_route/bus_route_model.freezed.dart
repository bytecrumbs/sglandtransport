// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'bus_route_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
BusRouteModel _$BusRouteModelFromJson(Map<String, dynamic> json) {
  return _BusRouteModel.fromJson(json);
}

class _$BusRouteModelTearOff {
  const _$BusRouteModelTearOff();

  _BusRouteModel call(
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
      @JsonKey(name: 'SUN_LastBus') String sunLastBus}) {
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
}

// ignore: unused_element
const $BusRouteModel = _$BusRouteModelTearOff();

mixin _$BusRouteModel {
  @JsonKey(name: 'ServiceNo')
  String get serviceNo;
  @JsonKey(name: 'Operator')
  String get busOperator;
  @JsonKey(name: 'Direction')
  int get direction;
  @JsonKey(name: 'StopSequence')
  int get stopSequence;
  @JsonKey(name: 'BusStopCode')
  String get busStopCode;
  @JsonKey(name: 'Distance')
  double get distance;
  @JsonKey(name: 'WD_FirstBus')
  String get wdFirstBus;
  @JsonKey(name: 'WD_LastBus')
  String get wdLastBus;
  @JsonKey(name: 'SAT_FirstBus')
  String get satFirstBus;
  @JsonKey(name: 'SAT_LastBus')
  String get satLastBus;
  @JsonKey(name: 'SUN_FirstBus')
  String get sunFirstBus;
  @JsonKey(name: 'SUN_LastBus')
  String get sunLastBus;

  Map<String, dynamic> toJson();
  $BusRouteModelCopyWith<BusRouteModel> get copyWith;
}

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

class _$BusRouteModelCopyWithImpl<$Res>
    implements $BusRouteModelCopyWith<$Res> {
  _$BusRouteModelCopyWithImpl(this._value, this._then);

  final BusRouteModel _value;
  // ignore: unused_field
  final $Res Function(BusRouteModel) _then;

  @override
  $Res call({
    Object serviceNo = freezed,
    Object busOperator = freezed,
    Object direction = freezed,
    Object stopSequence = freezed,
    Object busStopCode = freezed,
    Object distance = freezed,
    Object wdFirstBus = freezed,
    Object wdLastBus = freezed,
    Object satFirstBus = freezed,
    Object satLastBus = freezed,
    Object sunFirstBus = freezed,
    Object sunLastBus = freezed,
  }) {
    return _then(_value.copyWith(
      serviceNo: serviceNo == freezed ? _value.serviceNo : serviceNo as String,
      busOperator:
          busOperator == freezed ? _value.busOperator : busOperator as String,
      direction: direction == freezed ? _value.direction : direction as int,
      stopSequence:
          stopSequence == freezed ? _value.stopSequence : stopSequence as int,
      busStopCode:
          busStopCode == freezed ? _value.busStopCode : busStopCode as String,
      distance: distance == freezed ? _value.distance : distance as double,
      wdFirstBus:
          wdFirstBus == freezed ? _value.wdFirstBus : wdFirstBus as String,
      wdLastBus: wdLastBus == freezed ? _value.wdLastBus : wdLastBus as String,
      satFirstBus:
          satFirstBus == freezed ? _value.satFirstBus : satFirstBus as String,
      satLastBus:
          satLastBus == freezed ? _value.satLastBus : satLastBus as String,
      sunFirstBus:
          sunFirstBus == freezed ? _value.sunFirstBus : sunFirstBus as String,
      sunLastBus:
          sunLastBus == freezed ? _value.sunLastBus : sunLastBus as String,
    ));
  }
}

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
    Object serviceNo = freezed,
    Object busOperator = freezed,
    Object direction = freezed,
    Object stopSequence = freezed,
    Object busStopCode = freezed,
    Object distance = freezed,
    Object wdFirstBus = freezed,
    Object wdLastBus = freezed,
    Object satFirstBus = freezed,
    Object satLastBus = freezed,
    Object sunFirstBus = freezed,
    Object sunLastBus = freezed,
  }) {
    return _then(_BusRouteModel(
      serviceNo: serviceNo == freezed ? _value.serviceNo : serviceNo as String,
      busOperator:
          busOperator == freezed ? _value.busOperator : busOperator as String,
      direction: direction == freezed ? _value.direction : direction as int,
      stopSequence:
          stopSequence == freezed ? _value.stopSequence : stopSequence as int,
      busStopCode:
          busStopCode == freezed ? _value.busStopCode : busStopCode as String,
      distance: distance == freezed ? _value.distance : distance as double,
      wdFirstBus:
          wdFirstBus == freezed ? _value.wdFirstBus : wdFirstBus as String,
      wdLastBus: wdLastBus == freezed ? _value.wdLastBus : wdLastBus as String,
      satFirstBus:
          satFirstBus == freezed ? _value.satFirstBus : satFirstBus as String,
      satLastBus:
          satLastBus == freezed ? _value.satLastBus : satLastBus as String,
      sunFirstBus:
          sunFirstBus == freezed ? _value.sunFirstBus : sunFirstBus as String,
      sunLastBus:
          sunLastBus == freezed ? _value.sunLastBus : sunLastBus as String,
    ));
  }
}

@JsonSerializable()
class _$_BusRouteModel with DiagnosticableTreeMixin implements _BusRouteModel {
  _$_BusRouteModel(
      {@JsonKey(name: 'ServiceNo') this.serviceNo,
      @JsonKey(name: 'Operator') this.busOperator,
      @JsonKey(name: 'Direction') this.direction,
      @JsonKey(name: 'StopSequence') this.stopSequence,
      @JsonKey(name: 'BusStopCode') this.busStopCode,
      @JsonKey(name: 'Distance') this.distance,
      @JsonKey(name: 'WD_FirstBus') this.wdFirstBus,
      @JsonKey(name: 'WD_LastBus') this.wdLastBus,
      @JsonKey(name: 'SAT_FirstBus') this.satFirstBus,
      @JsonKey(name: 'SAT_LastBus') this.satLastBus,
      @JsonKey(name: 'SUN_FirstBus') this.sunFirstBus,
      @JsonKey(name: 'SUN_LastBus') this.sunLastBus});

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
      @JsonKey(name: 'SUN_LastBus') String sunLastBus}) = _$_BusRouteModel;

  factory _BusRouteModel.fromJson(Map<String, dynamic> json) =
      _$_BusRouteModel.fromJson;

  @override
  @JsonKey(name: 'ServiceNo')
  String get serviceNo;
  @override
  @JsonKey(name: 'Operator')
  String get busOperator;
  @override
  @JsonKey(name: 'Direction')
  int get direction;
  @override
  @JsonKey(name: 'StopSequence')
  int get stopSequence;
  @override
  @JsonKey(name: 'BusStopCode')
  String get busStopCode;
  @override
  @JsonKey(name: 'Distance')
  double get distance;
  @override
  @JsonKey(name: 'WD_FirstBus')
  String get wdFirstBus;
  @override
  @JsonKey(name: 'WD_LastBus')
  String get wdLastBus;
  @override
  @JsonKey(name: 'SAT_FirstBus')
  String get satFirstBus;
  @override
  @JsonKey(name: 'SAT_LastBus')
  String get satLastBus;
  @override
  @JsonKey(name: 'SUN_FirstBus')
  String get sunFirstBus;
  @override
  @JsonKey(name: 'SUN_LastBus')
  String get sunLastBus;
  @override
  _$BusRouteModelCopyWith<_BusRouteModel> get copyWith;
}
