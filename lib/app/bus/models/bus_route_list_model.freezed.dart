// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'bus_route_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusRouteListModel _$BusRouteListModelFromJson(Map<String, dynamic> json) {
  return _BusRouteListModel.fromJson(json);
}

/// @nodoc
class _$BusRouteListModelTearOff {
  const _$BusRouteListModelTearOff();

  _BusRouteListModel call(
      {@JsonKey(name: 'odata.metadata') String? odataMetadata,
      List<BusRouteModel?>? value}) {
    return _BusRouteListModel(
      odataMetadata: odataMetadata,
      value: value,
    );
  }

  BusRouteListModel fromJson(Map<String, Object> json) {
    return BusRouteListModel.fromJson(json);
  }
}

/// @nodoc
const $BusRouteListModel = _$BusRouteListModelTearOff();

/// @nodoc
mixin _$BusRouteListModel {
  @JsonKey(name: 'odata.metadata')
  String? get odataMetadata => throw _privateConstructorUsedError;
  List<BusRouteModel?>? get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusRouteListModelCopyWith<BusRouteListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusRouteListModelCopyWith<$Res> {
  factory $BusRouteListModelCopyWith(
          BusRouteListModel value, $Res Function(BusRouteListModel) then) =
      _$BusRouteListModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'odata.metadata') String? odataMetadata,
      List<BusRouteModel?>? value});
}

/// @nodoc
class _$BusRouteListModelCopyWithImpl<$Res>
    implements $BusRouteListModelCopyWith<$Res> {
  _$BusRouteListModelCopyWithImpl(this._value, this._then);

  final BusRouteListModel _value;
  // ignore: unused_field
  final $Res Function(BusRouteListModel) _then;

  @override
  $Res call({
    Object? odataMetadata = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      odataMetadata: odataMetadata == freezed
          ? _value.odataMetadata
          : odataMetadata // ignore: cast_nullable_to_non_nullable
              as String?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<BusRouteModel?>?,
    ));
  }
}

/// @nodoc
abstract class _$BusRouteListModelCopyWith<$Res>
    implements $BusRouteListModelCopyWith<$Res> {
  factory _$BusRouteListModelCopyWith(
          _BusRouteListModel value, $Res Function(_BusRouteListModel) then) =
      __$BusRouteListModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'odata.metadata') String? odataMetadata,
      List<BusRouteModel?>? value});
}

/// @nodoc
class __$BusRouteListModelCopyWithImpl<$Res>
    extends _$BusRouteListModelCopyWithImpl<$Res>
    implements _$BusRouteListModelCopyWith<$Res> {
  __$BusRouteListModelCopyWithImpl(
      _BusRouteListModel _value, $Res Function(_BusRouteListModel) _then)
      : super(_value, (v) => _then(v as _BusRouteListModel));

  @override
  _BusRouteListModel get _value => super._value as _BusRouteListModel;

  @override
  $Res call({
    Object? odataMetadata = freezed,
    Object? value = freezed,
  }) {
    return _then(_BusRouteListModel(
      odataMetadata: odataMetadata == freezed
          ? _value.odataMetadata
          : odataMetadata // ignore: cast_nullable_to_non_nullable
              as String?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<BusRouteModel?>?,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_BusRouteListModel
    with DiagnosticableTreeMixin
    implements _BusRouteListModel {
  _$_BusRouteListModel(
      {@JsonKey(name: 'odata.metadata') this.odataMetadata, this.value});

  factory _$_BusRouteListModel.fromJson(Map<String, dynamic> json) =>
      _$_$_BusRouteListModelFromJson(json);

  @override
  @JsonKey(name: 'odata.metadata')
  final String? odataMetadata;
  @override
  final List<BusRouteModel?>? value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BusRouteListModel(odataMetadata: $odataMetadata, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BusRouteListModel'))
      ..add(DiagnosticsProperty('odataMetadata', odataMetadata))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusRouteListModel &&
            (identical(other.odataMetadata, odataMetadata) ||
                const DeepCollectionEquality()
                    .equals(other.odataMetadata, odataMetadata)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(odataMetadata) ^
      const DeepCollectionEquality().hash(value);

  @JsonKey(ignore: true)
  @override
  _$BusRouteListModelCopyWith<_BusRouteListModel> get copyWith =>
      __$BusRouteListModelCopyWithImpl<_BusRouteListModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BusRouteListModelToJson(this);
  }
}

abstract class _BusRouteListModel implements BusRouteListModel {
  factory _BusRouteListModel(
      {@JsonKey(name: 'odata.metadata') String? odataMetadata,
      List<BusRouteModel?>? value}) = _$_BusRouteListModel;

  factory _BusRouteListModel.fromJson(Map<String, dynamic> json) =
      _$_BusRouteListModel.fromJson;

  @override
  @JsonKey(name: 'odata.metadata')
  String? get odataMetadata => throw _privateConstructorUsedError;
  @override
  List<BusRouteModel?>? get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BusRouteListModelCopyWith<_BusRouteListModel> get copyWith =>
      throw _privateConstructorUsedError;
}
