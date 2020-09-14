// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bus_arrival_service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
BusArrivalServiceModel _$BusArrivalServiceModelFromJson(
    Map<String, dynamic> json) {
  return _BusArrivalServiceModel.fromJson(json);
}

class _$BusArrivalServiceModelTearOff {
  const _$BusArrivalServiceModelTearOff();

// ignore: unused_element
  _BusArrivalServiceModel call(
      {@JsonKey(name: 'ServiceNo') String serviceNo,
      @JsonKey(name: 'Operator') String busOperator,
      @JsonKey(name: 'NextBus') NextBusModel nextBus,
      @JsonKey(name: 'NextBus2') NextBusModel nextBus2,
      @JsonKey(name: 'NextBus3') NextBusModel nextBus3,
      bool inService = true,
      String destinationName}) {
    return _BusArrivalServiceModel(
      serviceNo: serviceNo,
      busOperator: busOperator,
      nextBus: nextBus,
      nextBus2: nextBus2,
      nextBus3: nextBus3,
      inService: inService,
      destinationName: destinationName,
    );
  }
}

// ignore: unused_element
const $BusArrivalServiceModel = _$BusArrivalServiceModelTearOff();

mixin _$BusArrivalServiceModel {
  @JsonKey(name: 'ServiceNo')
  String get serviceNo;
  @JsonKey(name: 'Operator')
  String get busOperator;
  @JsonKey(name: 'NextBus')
  NextBusModel get nextBus;
  @JsonKey(name: 'NextBus2')
  NextBusModel get nextBus2;
  @JsonKey(name: 'NextBus3')
  NextBusModel get nextBus3;
  bool get inService;
  String get destinationName;

  Map<String, dynamic> toJson();
  $BusArrivalServiceModelCopyWith<BusArrivalServiceModel> get copyWith;
}

abstract class $BusArrivalServiceModelCopyWith<$Res> {
  factory $BusArrivalServiceModelCopyWith(BusArrivalServiceModel value,
          $Res Function(BusArrivalServiceModel) then) =
      _$BusArrivalServiceModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'ServiceNo') String serviceNo,
      @JsonKey(name: 'Operator') String busOperator,
      @JsonKey(name: 'NextBus') NextBusModel nextBus,
      @JsonKey(name: 'NextBus2') NextBusModel nextBus2,
      @JsonKey(name: 'NextBus3') NextBusModel nextBus3,
      bool inService,
      String destinationName});

  $NextBusModelCopyWith<$Res> get nextBus;
  $NextBusModelCopyWith<$Res> get nextBus2;
  $NextBusModelCopyWith<$Res> get nextBus3;
}

class _$BusArrivalServiceModelCopyWithImpl<$Res>
    implements $BusArrivalServiceModelCopyWith<$Res> {
  _$BusArrivalServiceModelCopyWithImpl(this._value, this._then);

  final BusArrivalServiceModel _value;
  // ignore: unused_field
  final $Res Function(BusArrivalServiceModel) _then;

  @override
  $Res call({
    Object serviceNo = freezed,
    Object busOperator = freezed,
    Object nextBus = freezed,
    Object nextBus2 = freezed,
    Object nextBus3 = freezed,
    Object inService = freezed,
    Object destinationName = freezed,
  }) {
    return _then(_value.copyWith(
      serviceNo: serviceNo == freezed ? _value.serviceNo : serviceNo as String,
      busOperator:
          busOperator == freezed ? _value.busOperator : busOperator as String,
      nextBus: nextBus == freezed ? _value.nextBus : nextBus as NextBusModel,
      nextBus2:
          nextBus2 == freezed ? _value.nextBus2 : nextBus2 as NextBusModel,
      nextBus3:
          nextBus3 == freezed ? _value.nextBus3 : nextBus3 as NextBusModel,
      inService: inService == freezed ? _value.inService : inService as bool,
      destinationName: destinationName == freezed
          ? _value.destinationName
          : destinationName as String,
    ));
  }

  @override
  $NextBusModelCopyWith<$Res> get nextBus {
    if (_value.nextBus == null) {
      return null;
    }
    return $NextBusModelCopyWith<$Res>(_value.nextBus, (value) {
      return _then(_value.copyWith(nextBus: value));
    });
  }

  @override
  $NextBusModelCopyWith<$Res> get nextBus2 {
    if (_value.nextBus2 == null) {
      return null;
    }
    return $NextBusModelCopyWith<$Res>(_value.nextBus2, (value) {
      return _then(_value.copyWith(nextBus2: value));
    });
  }

  @override
  $NextBusModelCopyWith<$Res> get nextBus3 {
    if (_value.nextBus3 == null) {
      return null;
    }
    return $NextBusModelCopyWith<$Res>(_value.nextBus3, (value) {
      return _then(_value.copyWith(nextBus3: value));
    });
  }
}

abstract class _$BusArrivalServiceModelCopyWith<$Res>
    implements $BusArrivalServiceModelCopyWith<$Res> {
  factory _$BusArrivalServiceModelCopyWith(_BusArrivalServiceModel value,
          $Res Function(_BusArrivalServiceModel) then) =
      __$BusArrivalServiceModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'ServiceNo') String serviceNo,
      @JsonKey(name: 'Operator') String busOperator,
      @JsonKey(name: 'NextBus') NextBusModel nextBus,
      @JsonKey(name: 'NextBus2') NextBusModel nextBus2,
      @JsonKey(name: 'NextBus3') NextBusModel nextBus3,
      bool inService,
      String destinationName});

  @override
  $NextBusModelCopyWith<$Res> get nextBus;
  @override
  $NextBusModelCopyWith<$Res> get nextBus2;
  @override
  $NextBusModelCopyWith<$Res> get nextBus3;
}

class __$BusArrivalServiceModelCopyWithImpl<$Res>
    extends _$BusArrivalServiceModelCopyWithImpl<$Res>
    implements _$BusArrivalServiceModelCopyWith<$Res> {
  __$BusArrivalServiceModelCopyWithImpl(_BusArrivalServiceModel _value,
      $Res Function(_BusArrivalServiceModel) _then)
      : super(_value, (v) => _then(v as _BusArrivalServiceModel));

  @override
  _BusArrivalServiceModel get _value => super._value as _BusArrivalServiceModel;

  @override
  $Res call({
    Object serviceNo = freezed,
    Object busOperator = freezed,
    Object nextBus = freezed,
    Object nextBus2 = freezed,
    Object nextBus3 = freezed,
    Object inService = freezed,
    Object destinationName = freezed,
  }) {
    return _then(_BusArrivalServiceModel(
      serviceNo: serviceNo == freezed ? _value.serviceNo : serviceNo as String,
      busOperator:
          busOperator == freezed ? _value.busOperator : busOperator as String,
      nextBus: nextBus == freezed ? _value.nextBus : nextBus as NextBusModel,
      nextBus2:
          nextBus2 == freezed ? _value.nextBus2 : nextBus2 as NextBusModel,
      nextBus3:
          nextBus3 == freezed ? _value.nextBus3 : nextBus3 as NextBusModel,
      inService: inService == freezed ? _value.inService : inService as bool,
      destinationName: destinationName == freezed
          ? _value.destinationName
          : destinationName as String,
    ));
  }
}

@JsonSerializable()
class _$_BusArrivalServiceModel
    with DiagnosticableTreeMixin
    implements _BusArrivalServiceModel {
  _$_BusArrivalServiceModel(
      {@JsonKey(name: 'ServiceNo') this.serviceNo,
      @JsonKey(name: 'Operator') this.busOperator,
      @JsonKey(name: 'NextBus') this.nextBus,
      @JsonKey(name: 'NextBus2') this.nextBus2,
      @JsonKey(name: 'NextBus3') this.nextBus3,
      this.inService = true,
      this.destinationName})
      : assert(inService != null);

  factory _$_BusArrivalServiceModel.fromJson(Map<String, dynamic> json) =>
      _$_$_BusArrivalServiceModelFromJson(json);

  @override
  @JsonKey(name: 'ServiceNo')
  final String serviceNo;
  @override
  @JsonKey(name: 'Operator')
  final String busOperator;
  @override
  @JsonKey(name: 'NextBus')
  final NextBusModel nextBus;
  @override
  @JsonKey(name: 'NextBus2')
  final NextBusModel nextBus2;
  @override
  @JsonKey(name: 'NextBus3')
  final NextBusModel nextBus3;
  @JsonKey(defaultValue: true)
  @override
  final bool inService;
  @override
  final String destinationName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BusArrivalServiceModel(serviceNo: $serviceNo, busOperator: $busOperator, nextBus: $nextBus, nextBus2: $nextBus2, nextBus3: $nextBus3, inService: $inService, destinationName: $destinationName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BusArrivalServiceModel'))
      ..add(DiagnosticsProperty('serviceNo', serviceNo))
      ..add(DiagnosticsProperty('busOperator', busOperator))
      ..add(DiagnosticsProperty('nextBus', nextBus))
      ..add(DiagnosticsProperty('nextBus2', nextBus2))
      ..add(DiagnosticsProperty('nextBus3', nextBus3))
      ..add(DiagnosticsProperty('inService', inService))
      ..add(DiagnosticsProperty('destinationName', destinationName));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusArrivalServiceModel &&
            (identical(other.serviceNo, serviceNo) ||
                const DeepCollectionEquality()
                    .equals(other.serviceNo, serviceNo)) &&
            (identical(other.busOperator, busOperator) ||
                const DeepCollectionEquality()
                    .equals(other.busOperator, busOperator)) &&
            (identical(other.nextBus, nextBus) ||
                const DeepCollectionEquality()
                    .equals(other.nextBus, nextBus)) &&
            (identical(other.nextBus2, nextBus2) ||
                const DeepCollectionEquality()
                    .equals(other.nextBus2, nextBus2)) &&
            (identical(other.nextBus3, nextBus3) ||
                const DeepCollectionEquality()
                    .equals(other.nextBus3, nextBus3)) &&
            (identical(other.inService, inService) ||
                const DeepCollectionEquality()
                    .equals(other.inService, inService)) &&
            (identical(other.destinationName, destinationName) ||
                const DeepCollectionEquality()
                    .equals(other.destinationName, destinationName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(serviceNo) ^
      const DeepCollectionEquality().hash(busOperator) ^
      const DeepCollectionEquality().hash(nextBus) ^
      const DeepCollectionEquality().hash(nextBus2) ^
      const DeepCollectionEquality().hash(nextBus3) ^
      const DeepCollectionEquality().hash(inService) ^
      const DeepCollectionEquality().hash(destinationName);

  @override
  _$BusArrivalServiceModelCopyWith<_BusArrivalServiceModel> get copyWith =>
      __$BusArrivalServiceModelCopyWithImpl<_BusArrivalServiceModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BusArrivalServiceModelToJson(this);
  }
}

abstract class _BusArrivalServiceModel implements BusArrivalServiceModel {
  factory _BusArrivalServiceModel(
      {@JsonKey(name: 'ServiceNo') String serviceNo,
      @JsonKey(name: 'Operator') String busOperator,
      @JsonKey(name: 'NextBus') NextBusModel nextBus,
      @JsonKey(name: 'NextBus2') NextBusModel nextBus2,
      @JsonKey(name: 'NextBus3') NextBusModel nextBus3,
      bool inService,
      String destinationName}) = _$_BusArrivalServiceModel;

  factory _BusArrivalServiceModel.fromJson(Map<String, dynamic> json) =
      _$_BusArrivalServiceModel.fromJson;

  @override
  @JsonKey(name: 'ServiceNo')
  String get serviceNo;
  @override
  @JsonKey(name: 'Operator')
  String get busOperator;
  @override
  @JsonKey(name: 'NextBus')
  NextBusModel get nextBus;
  @override
  @JsonKey(name: 'NextBus2')
  NextBusModel get nextBus2;
  @override
  @JsonKey(name: 'NextBus3')
  NextBusModel get nextBus3;
  @override
  bool get inService;
  @override
  String get destinationName;
  @override
  _$BusArrivalServiceModelCopyWith<_BusArrivalServiceModel> get copyWith;
}
