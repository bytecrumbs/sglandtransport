// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'bus_arrival_service_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusArrivalServiceListModel _$BusArrivalServiceListModelFromJson(
    Map<String, dynamic> json) {
  return _BusArrivalServiceListModel.fromJson(json);
}

/// @nodoc
class _$BusArrivalServiceListModelTearOff {
  const _$BusArrivalServiceListModelTearOff();

  _BusArrivalServiceListModel call(
      {@JsonKey(name: 'odata.metadata')
          required String odataMetadata,
      @JsonKey(name: 'BusStopCode')
          required String busStopCode,
      @JsonKey(name: 'Services')
          required List<BusArrivalServiceModel> services}) {
    return _BusArrivalServiceListModel(
      odataMetadata: odataMetadata,
      busStopCode: busStopCode,
      services: services,
    );
  }

  BusArrivalServiceListModel fromJson(Map<String, Object> json) {
    return BusArrivalServiceListModel.fromJson(json);
  }
}

/// @nodoc
const $BusArrivalServiceListModel = _$BusArrivalServiceListModelTearOff();

/// @nodoc
mixin _$BusArrivalServiceListModel {
  @JsonKey(name: 'odata.metadata')
  String get odataMetadata => throw _privateConstructorUsedError;
  @JsonKey(name: 'BusStopCode')
  String get busStopCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'Services')
  List<BusArrivalServiceModel> get services =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusArrivalServiceListModelCopyWith<BusArrivalServiceListModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusArrivalServiceListModelCopyWith<$Res> {
  factory $BusArrivalServiceListModelCopyWith(BusArrivalServiceListModel value,
          $Res Function(BusArrivalServiceListModel) then) =
      _$BusArrivalServiceListModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'odata.metadata') String odataMetadata,
      @JsonKey(name: 'BusStopCode') String busStopCode,
      @JsonKey(name: 'Services') List<BusArrivalServiceModel> services});
}

/// @nodoc
class _$BusArrivalServiceListModelCopyWithImpl<$Res>
    implements $BusArrivalServiceListModelCopyWith<$Res> {
  _$BusArrivalServiceListModelCopyWithImpl(this._value, this._then);

  final BusArrivalServiceListModel _value;
  // ignore: unused_field
  final $Res Function(BusArrivalServiceListModel) _then;

  @override
  $Res call({
    Object? odataMetadata = freezed,
    Object? busStopCode = freezed,
    Object? services = freezed,
  }) {
    return _then(_value.copyWith(
      odataMetadata: odataMetadata == freezed
          ? _value.odataMetadata
          : odataMetadata // ignore: cast_nullable_to_non_nullable
              as String,
      busStopCode: busStopCode == freezed
          ? _value.busStopCode
          : busStopCode // ignore: cast_nullable_to_non_nullable
              as String,
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<BusArrivalServiceModel>,
    ));
  }
}

/// @nodoc
abstract class _$BusArrivalServiceListModelCopyWith<$Res>
    implements $BusArrivalServiceListModelCopyWith<$Res> {
  factory _$BusArrivalServiceListModelCopyWith(
          _BusArrivalServiceListModel value,
          $Res Function(_BusArrivalServiceListModel) then) =
      __$BusArrivalServiceListModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'odata.metadata') String odataMetadata,
      @JsonKey(name: 'BusStopCode') String busStopCode,
      @JsonKey(name: 'Services') List<BusArrivalServiceModel> services});
}

/// @nodoc
class __$BusArrivalServiceListModelCopyWithImpl<$Res>
    extends _$BusArrivalServiceListModelCopyWithImpl<$Res>
    implements _$BusArrivalServiceListModelCopyWith<$Res> {
  __$BusArrivalServiceListModelCopyWithImpl(_BusArrivalServiceListModel _value,
      $Res Function(_BusArrivalServiceListModel) _then)
      : super(_value, (v) => _then(v as _BusArrivalServiceListModel));

  @override
  _BusArrivalServiceListModel get _value =>
      super._value as _BusArrivalServiceListModel;

  @override
  $Res call({
    Object? odataMetadata = freezed,
    Object? busStopCode = freezed,
    Object? services = freezed,
  }) {
    return _then(_BusArrivalServiceListModel(
      odataMetadata: odataMetadata == freezed
          ? _value.odataMetadata
          : odataMetadata // ignore: cast_nullable_to_non_nullable
              as String,
      busStopCode: busStopCode == freezed
          ? _value.busStopCode
          : busStopCode // ignore: cast_nullable_to_non_nullable
              as String,
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<BusArrivalServiceModel>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_BusArrivalServiceListModel
    with DiagnosticableTreeMixin
    implements _BusArrivalServiceListModel {
  _$_BusArrivalServiceListModel(
      {@JsonKey(name: 'odata.metadata') required this.odataMetadata,
      @JsonKey(name: 'BusStopCode') required this.busStopCode,
      @JsonKey(name: 'Services') required this.services});

  factory _$_BusArrivalServiceListModel.fromJson(Map<String, dynamic> json) =>
      _$_$_BusArrivalServiceListModelFromJson(json);

  @override
  @JsonKey(name: 'odata.metadata')
  final String odataMetadata;
  @override
  @JsonKey(name: 'BusStopCode')
  final String busStopCode;
  @override
  @JsonKey(name: 'Services')
  final List<BusArrivalServiceModel> services;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BusArrivalServiceListModel(odataMetadata: $odataMetadata, busStopCode: $busStopCode, services: $services)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BusArrivalServiceListModel'))
      ..add(DiagnosticsProperty('odataMetadata', odataMetadata))
      ..add(DiagnosticsProperty('busStopCode', busStopCode))
      ..add(DiagnosticsProperty('services', services));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusArrivalServiceListModel &&
            (identical(other.odataMetadata, odataMetadata) ||
                const DeepCollectionEquality()
                    .equals(other.odataMetadata, odataMetadata)) &&
            (identical(other.busStopCode, busStopCode) ||
                const DeepCollectionEquality()
                    .equals(other.busStopCode, busStopCode)) &&
            (identical(other.services, services) ||
                const DeepCollectionEquality()
                    .equals(other.services, services)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(odataMetadata) ^
      const DeepCollectionEquality().hash(busStopCode) ^
      const DeepCollectionEquality().hash(services);

  @JsonKey(ignore: true)
  @override
  _$BusArrivalServiceListModelCopyWith<_BusArrivalServiceListModel>
      get copyWith => __$BusArrivalServiceListModelCopyWithImpl<
          _BusArrivalServiceListModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BusArrivalServiceListModelToJson(this);
  }
}

abstract class _BusArrivalServiceListModel
    implements BusArrivalServiceListModel {
  factory _BusArrivalServiceListModel(
          {@JsonKey(name: 'odata.metadata')
              required String odataMetadata,
          @JsonKey(name: 'BusStopCode')
              required String busStopCode,
          @JsonKey(name: 'Services')
              required List<BusArrivalServiceModel> services}) =
      _$_BusArrivalServiceListModel;

  factory _BusArrivalServiceListModel.fromJson(Map<String, dynamic> json) =
      _$_BusArrivalServiceListModel.fromJson;

  @override
  @JsonKey(name: 'odata.metadata')
  String get odataMetadata => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'BusStopCode')
  String get busStopCode => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: 'Services')
  List<BusArrivalServiceModel> get services =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BusArrivalServiceListModelCopyWith<_BusArrivalServiceListModel>
      get copyWith => throw _privateConstructorUsedError;
}
