// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'bus_stop_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusStopListModel _$BusStopListModelFromJson(Map<String, dynamic> json) {
  return _BusStopListModel.fromJson(json);
}

/// @nodoc
class _$BusStopListModelTearOff {
  const _$BusStopListModelTearOff();

  _BusStopListModel call(
      {@JsonKey(name: 'odata.metadata') required String odataMetadata,
      required List<BusStopModel> value}) {
    return _BusStopListModel(
      odataMetadata: odataMetadata,
      value: value,
    );
  }

  BusStopListModel fromJson(Map<String, Object> json) {
    return BusStopListModel.fromJson(json);
  }
}

/// @nodoc
const $BusStopListModel = _$BusStopListModelTearOff();

/// @nodoc
mixin _$BusStopListModel {
  @JsonKey(name: 'odata.metadata')
  String get odataMetadata => throw _privateConstructorUsedError;
  List<BusStopModel> get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusStopListModelCopyWith<BusStopListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusStopListModelCopyWith<$Res> {
  factory $BusStopListModelCopyWith(
          BusStopListModel value, $Res Function(BusStopListModel) then) =
      _$BusStopListModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'odata.metadata') String odataMetadata,
      List<BusStopModel> value});
}

/// @nodoc
class _$BusStopListModelCopyWithImpl<$Res>
    implements $BusStopListModelCopyWith<$Res> {
  _$BusStopListModelCopyWithImpl(this._value, this._then);

  final BusStopListModel _value;
  // ignore: unused_field
  final $Res Function(BusStopListModel) _then;

  @override
  $Res call({
    Object? odataMetadata = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      odataMetadata: odataMetadata == freezed
          ? _value.odataMetadata
          : odataMetadata // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<BusStopModel>,
    ));
  }
}

/// @nodoc
abstract class _$BusStopListModelCopyWith<$Res>
    implements $BusStopListModelCopyWith<$Res> {
  factory _$BusStopListModelCopyWith(
          _BusStopListModel value, $Res Function(_BusStopListModel) then) =
      __$BusStopListModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'odata.metadata') String odataMetadata,
      List<BusStopModel> value});
}

/// @nodoc
class __$BusStopListModelCopyWithImpl<$Res>
    extends _$BusStopListModelCopyWithImpl<$Res>
    implements _$BusStopListModelCopyWith<$Res> {
  __$BusStopListModelCopyWithImpl(
      _BusStopListModel _value, $Res Function(_BusStopListModel) _then)
      : super(_value, (v) => _then(v as _BusStopListModel));

  @override
  _BusStopListModel get _value => super._value as _BusStopListModel;

  @override
  $Res call({
    Object? odataMetadata = freezed,
    Object? value = freezed,
  }) {
    return _then(_BusStopListModel(
      odataMetadata: odataMetadata == freezed
          ? _value.odataMetadata
          : odataMetadata // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<BusStopModel>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_BusStopListModel
    with DiagnosticableTreeMixin
    implements _BusStopListModel {
  _$_BusStopListModel(
      {@JsonKey(name: 'odata.metadata') required this.odataMetadata,
      required this.value});

  factory _$_BusStopListModel.fromJson(Map<String, dynamic> json) =>
      _$_$_BusStopListModelFromJson(json);

  @override
  @JsonKey(name: 'odata.metadata')
  final String odataMetadata;
  @override
  final List<BusStopModel> value;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BusStopListModel(odataMetadata: $odataMetadata, value: $value)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BusStopListModel'))
      ..add(DiagnosticsProperty('odataMetadata', odataMetadata))
      ..add(DiagnosticsProperty('value', value));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusStopListModel &&
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
  _$BusStopListModelCopyWith<_BusStopListModel> get copyWith =>
      __$BusStopListModelCopyWithImpl<_BusStopListModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BusStopListModelToJson(this);
  }
}

abstract class _BusStopListModel implements BusStopListModel {
  factory _BusStopListModel(
      {@JsonKey(name: 'odata.metadata') required String odataMetadata,
      required List<BusStopModel> value}) = _$_BusStopListModel;

  factory _BusStopListModel.fromJson(Map<String, dynamic> json) =
      _$_BusStopListModel.fromJson;

  @override
  @JsonKey(name: 'odata.metadata')
  String get odataMetadata => throw _privateConstructorUsedError;
  @override
  List<BusStopModel> get value => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BusStopListModelCopyWith<_BusStopListModel> get copyWith =>
      throw _privateConstructorUsedError;
}
