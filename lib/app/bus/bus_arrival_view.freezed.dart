// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bus_arrival_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$TimerProviderParameterTearOff {
  const _$TimerProviderParameterTearOff();

// ignore: unused_element
  _TimerProviderParameter call({BuildContext context, String busStopCode}) {
    return _TimerProviderParameter(
      context: context,
      busStopCode: busStopCode,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $TimerProviderParameter = _$TimerProviderParameterTearOff();

/// @nodoc
mixin _$TimerProviderParameter {
  BuildContext get context;
  String get busStopCode;

  $TimerProviderParameterCopyWith<TimerProviderParameter> get copyWith;
}

/// @nodoc
abstract class $TimerProviderParameterCopyWith<$Res> {
  factory $TimerProviderParameterCopyWith(TimerProviderParameter value,
          $Res Function(TimerProviderParameter) then) =
      _$TimerProviderParameterCopyWithImpl<$Res>;
  $Res call({BuildContext context, String busStopCode});
}

/// @nodoc
class _$TimerProviderParameterCopyWithImpl<$Res>
    implements $TimerProviderParameterCopyWith<$Res> {
  _$TimerProviderParameterCopyWithImpl(this._value, this._then);

  final TimerProviderParameter _value;
  // ignore: unused_field
  final $Res Function(TimerProviderParameter) _then;

  @override
  $Res call({
    Object context = freezed,
    Object busStopCode = freezed,
  }) {
    return _then(_value.copyWith(
      context: context == freezed ? _value.context : context as BuildContext,
      busStopCode:
          busStopCode == freezed ? _value.busStopCode : busStopCode as String,
    ));
  }
}

/// @nodoc
abstract class _$TimerProviderParameterCopyWith<$Res>
    implements $TimerProviderParameterCopyWith<$Res> {
  factory _$TimerProviderParameterCopyWith(_TimerProviderParameter value,
          $Res Function(_TimerProviderParameter) then) =
      __$TimerProviderParameterCopyWithImpl<$Res>;
  @override
  $Res call({BuildContext context, String busStopCode});
}

/// @nodoc
class __$TimerProviderParameterCopyWithImpl<$Res>
    extends _$TimerProviderParameterCopyWithImpl<$Res>
    implements _$TimerProviderParameterCopyWith<$Res> {
  __$TimerProviderParameterCopyWithImpl(_TimerProviderParameter _value,
      $Res Function(_TimerProviderParameter) _then)
      : super(_value, (v) => _then(v as _TimerProviderParameter));

  @override
  _TimerProviderParameter get _value => super._value as _TimerProviderParameter;

  @override
  $Res call({
    Object context = freezed,
    Object busStopCode = freezed,
  }) {
    return _then(_TimerProviderParameter(
      context: context == freezed ? _value.context : context as BuildContext,
      busStopCode:
          busStopCode == freezed ? _value.busStopCode : busStopCode as String,
    ));
  }
}

/// @nodoc
class _$_TimerProviderParameter implements _TimerProviderParameter {
  _$_TimerProviderParameter({this.context, this.busStopCode});

  @override
  final BuildContext context;
  @override
  final String busStopCode;

  @override
  String toString() {
    return 'TimerProviderParameter(context: $context, busStopCode: $busStopCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TimerProviderParameter &&
            (identical(other.context, context) ||
                const DeepCollectionEquality()
                    .equals(other.context, context)) &&
            (identical(other.busStopCode, busStopCode) ||
                const DeepCollectionEquality()
                    .equals(other.busStopCode, busStopCode)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(context) ^
      const DeepCollectionEquality().hash(busStopCode);

  @override
  _$TimerProviderParameterCopyWith<_TimerProviderParameter> get copyWith =>
      __$TimerProviderParameterCopyWithImpl<_TimerProviderParameter>(
          this, _$identity);
}

abstract class _TimerProviderParameter implements TimerProviderParameter {
  factory _TimerProviderParameter({BuildContext context, String busStopCode}) =
      _$_TimerProviderParameter;

  @override
  BuildContext get context;
  @override
  String get busStopCode;
  @override
  _$TimerProviderParameterCopyWith<_TimerProviderParameter> get copyWith;
}
