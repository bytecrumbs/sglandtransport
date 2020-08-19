// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'next_bus_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
NextBusModel _$NextBusModelFromJson(Map<String, dynamic> json) {
  return _NextBusModel.fromJson(json);
}

class _$NextBusModelTearOff {
  const _$NextBusModelTearOff();

// ignore: unused_element
  _NextBusModel call(
      {@JsonKey(name: 'OriginCode') String originCode,
      @JsonKey(name: 'DestinationCode') String destinationCode,
      @JsonKey(name: 'EstimatedArrival') String estimatedArrival,
      @JsonKey(name: 'Latitude') String latitude,
      @JsonKey(name: 'Longitude') String longitude,
      @JsonKey(name: 'VisitNumber') String visitNumber,
      @JsonKey(name: 'Load') String load,
      @JsonKey(name: 'Feature') String feature,
      @JsonKey(name: 'Type') String type}) {
    return _NextBusModel(
      originCode: originCode,
      destinationCode: destinationCode,
      estimatedArrival: estimatedArrival,
      latitude: latitude,
      longitude: longitude,
      visitNumber: visitNumber,
      load: load,
      feature: feature,
      type: type,
    );
  }
}

// ignore: unused_element
const $NextBusModel = _$NextBusModelTearOff();

mixin _$NextBusModel {
  @JsonKey(name: 'OriginCode')
  String get originCode;
  @JsonKey(name: 'DestinationCode')
  String get destinationCode;
  @JsonKey(name: 'EstimatedArrival')
  String get estimatedArrival;
  @JsonKey(name: 'Latitude')
  String get latitude;
  @JsonKey(name: 'Longitude')
  String get longitude;
  @JsonKey(name: 'VisitNumber')
  String get visitNumber;
  @JsonKey(name: 'Load')
  String get load;
  @JsonKey(name: 'Feature')
  String get feature;
  @JsonKey(name: 'Type')
  String get type;

  Map<String, dynamic> toJson();
  $NextBusModelCopyWith<NextBusModel> get copyWith;
}

abstract class $NextBusModelCopyWith<$Res> {
  factory $NextBusModelCopyWith(
          NextBusModel value, $Res Function(NextBusModel) then) =
      _$NextBusModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'OriginCode') String originCode,
      @JsonKey(name: 'DestinationCode') String destinationCode,
      @JsonKey(name: 'EstimatedArrival') String estimatedArrival,
      @JsonKey(name: 'Latitude') String latitude,
      @JsonKey(name: 'Longitude') String longitude,
      @JsonKey(name: 'VisitNumber') String visitNumber,
      @JsonKey(name: 'Load') String load,
      @JsonKey(name: 'Feature') String feature,
      @JsonKey(name: 'Type') String type});
}

class _$NextBusModelCopyWithImpl<$Res> implements $NextBusModelCopyWith<$Res> {
  _$NextBusModelCopyWithImpl(this._value, this._then);

  final NextBusModel _value;
  // ignore: unused_field
  final $Res Function(NextBusModel) _then;

  @override
  $Res call({
    Object originCode = freezed,
    Object destinationCode = freezed,
    Object estimatedArrival = freezed,
    Object latitude = freezed,
    Object longitude = freezed,
    Object visitNumber = freezed,
    Object load = freezed,
    Object feature = freezed,
    Object type = freezed,
  }) {
    return _then(_value.copyWith(
      originCode:
          originCode == freezed ? _value.originCode : originCode as String,
      destinationCode: destinationCode == freezed
          ? _value.destinationCode
          : destinationCode as String,
      estimatedArrival: estimatedArrival == freezed
          ? _value.estimatedArrival
          : estimatedArrival as String,
      latitude: latitude == freezed ? _value.latitude : latitude as String,
      longitude: longitude == freezed ? _value.longitude : longitude as String,
      visitNumber:
          visitNumber == freezed ? _value.visitNumber : visitNumber as String,
      load: load == freezed ? _value.load : load as String,
      feature: feature == freezed ? _value.feature : feature as String,
      type: type == freezed ? _value.type : type as String,
    ));
  }
}

abstract class _$NextBusModelCopyWith<$Res>
    implements $NextBusModelCopyWith<$Res> {
  factory _$NextBusModelCopyWith(
          _NextBusModel value, $Res Function(_NextBusModel) then) =
      __$NextBusModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'OriginCode') String originCode,
      @JsonKey(name: 'DestinationCode') String destinationCode,
      @JsonKey(name: 'EstimatedArrival') String estimatedArrival,
      @JsonKey(name: 'Latitude') String latitude,
      @JsonKey(name: 'Longitude') String longitude,
      @JsonKey(name: 'VisitNumber') String visitNumber,
      @JsonKey(name: 'Load') String load,
      @JsonKey(name: 'Feature') String feature,
      @JsonKey(name: 'Type') String type});
}

class __$NextBusModelCopyWithImpl<$Res> extends _$NextBusModelCopyWithImpl<$Res>
    implements _$NextBusModelCopyWith<$Res> {
  __$NextBusModelCopyWithImpl(
      _NextBusModel _value, $Res Function(_NextBusModel) _then)
      : super(_value, (v) => _then(v as _NextBusModel));

  @override
  _NextBusModel get _value => super._value as _NextBusModel;

  @override
  $Res call({
    Object originCode = freezed,
    Object destinationCode = freezed,
    Object estimatedArrival = freezed,
    Object latitude = freezed,
    Object longitude = freezed,
    Object visitNumber = freezed,
    Object load = freezed,
    Object feature = freezed,
    Object type = freezed,
  }) {
    return _then(_NextBusModel(
      originCode:
          originCode == freezed ? _value.originCode : originCode as String,
      destinationCode: destinationCode == freezed
          ? _value.destinationCode
          : destinationCode as String,
      estimatedArrival: estimatedArrival == freezed
          ? _value.estimatedArrival
          : estimatedArrival as String,
      latitude: latitude == freezed ? _value.latitude : latitude as String,
      longitude: longitude == freezed ? _value.longitude : longitude as String,
      visitNumber:
          visitNumber == freezed ? _value.visitNumber : visitNumber as String,
      load: load == freezed ? _value.load : load as String,
      feature: feature == freezed ? _value.feature : feature as String,
      type: type == freezed ? _value.type : type as String,
    ));
  }
}

@JsonSerializable()
class _$_NextBusModel with DiagnosticableTreeMixin implements _NextBusModel {
  _$_NextBusModel(
      {@JsonKey(name: 'OriginCode') this.originCode,
      @JsonKey(name: 'DestinationCode') this.destinationCode,
      @JsonKey(name: 'EstimatedArrival') this.estimatedArrival,
      @JsonKey(name: 'Latitude') this.latitude,
      @JsonKey(name: 'Longitude') this.longitude,
      @JsonKey(name: 'VisitNumber') this.visitNumber,
      @JsonKey(name: 'Load') this.load,
      @JsonKey(name: 'Feature') this.feature,
      @JsonKey(name: 'Type') this.type});

  factory _$_NextBusModel.fromJson(Map<String, dynamic> json) =>
      _$_$_NextBusModelFromJson(json);

  @override
  @JsonKey(name: 'OriginCode')
  final String originCode;
  @override
  @JsonKey(name: 'DestinationCode')
  final String destinationCode;
  @override
  @JsonKey(name: 'EstimatedArrival')
  final String estimatedArrival;
  @override
  @JsonKey(name: 'Latitude')
  final String latitude;
  @override
  @JsonKey(name: 'Longitude')
  final String longitude;
  @override
  @JsonKey(name: 'VisitNumber')
  final String visitNumber;
  @override
  @JsonKey(name: 'Load')
  final String load;
  @override
  @JsonKey(name: 'Feature')
  final String feature;
  @override
  @JsonKey(name: 'Type')
  final String type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NextBusModel(originCode: $originCode, destinationCode: $destinationCode, estimatedArrival: $estimatedArrival, latitude: $latitude, longitude: $longitude, visitNumber: $visitNumber, load: $load, feature: $feature, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NextBusModel'))
      ..add(DiagnosticsProperty('originCode', originCode))
      ..add(DiagnosticsProperty('destinationCode', destinationCode))
      ..add(DiagnosticsProperty('estimatedArrival', estimatedArrival))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude))
      ..add(DiagnosticsProperty('visitNumber', visitNumber))
      ..add(DiagnosticsProperty('load', load))
      ..add(DiagnosticsProperty('feature', feature))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NextBusModel &&
            (identical(other.originCode, originCode) ||
                const DeepCollectionEquality()
                    .equals(other.originCode, originCode)) &&
            (identical(other.destinationCode, destinationCode) ||
                const DeepCollectionEquality()
                    .equals(other.destinationCode, destinationCode)) &&
            (identical(other.estimatedArrival, estimatedArrival) ||
                const DeepCollectionEquality()
                    .equals(other.estimatedArrival, estimatedArrival)) &&
            (identical(other.latitude, latitude) ||
                const DeepCollectionEquality()
                    .equals(other.latitude, latitude)) &&
            (identical(other.longitude, longitude) ||
                const DeepCollectionEquality()
                    .equals(other.longitude, longitude)) &&
            (identical(other.visitNumber, visitNumber) ||
                const DeepCollectionEquality()
                    .equals(other.visitNumber, visitNumber)) &&
            (identical(other.load, load) ||
                const DeepCollectionEquality().equals(other.load, load)) &&
            (identical(other.feature, feature) ||
                const DeepCollectionEquality()
                    .equals(other.feature, feature)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(originCode) ^
      const DeepCollectionEquality().hash(destinationCode) ^
      const DeepCollectionEquality().hash(estimatedArrival) ^
      const DeepCollectionEquality().hash(latitude) ^
      const DeepCollectionEquality().hash(longitude) ^
      const DeepCollectionEquality().hash(visitNumber) ^
      const DeepCollectionEquality().hash(load) ^
      const DeepCollectionEquality().hash(feature) ^
      const DeepCollectionEquality().hash(type);

  @override
  _$NextBusModelCopyWith<_NextBusModel> get copyWith =>
      __$NextBusModelCopyWithImpl<_NextBusModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NextBusModelToJson(this);
  }
}

abstract class _NextBusModel implements NextBusModel {
  factory _NextBusModel(
      {@JsonKey(name: 'OriginCode') String originCode,
      @JsonKey(name: 'DestinationCode') String destinationCode,
      @JsonKey(name: 'EstimatedArrival') String estimatedArrival,
      @JsonKey(name: 'Latitude') String latitude,
      @JsonKey(name: 'Longitude') String longitude,
      @JsonKey(name: 'VisitNumber') String visitNumber,
      @JsonKey(name: 'Load') String load,
      @JsonKey(name: 'Feature') String feature,
      @JsonKey(name: 'Type') String type}) = _$_NextBusModel;

  factory _NextBusModel.fromJson(Map<String, dynamic> json) =
      _$_NextBusModel.fromJson;

  @override
  @JsonKey(name: 'OriginCode')
  String get originCode;
  @override
  @JsonKey(name: 'DestinationCode')
  String get destinationCode;
  @override
  @JsonKey(name: 'EstimatedArrival')
  String get estimatedArrival;
  @override
  @JsonKey(name: 'Latitude')
  String get latitude;
  @override
  @JsonKey(name: 'Longitude')
  String get longitude;
  @override
  @JsonKey(name: 'VisitNumber')
  String get visitNumber;
  @override
  @JsonKey(name: 'Load')
  String get load;
  @override
  @JsonKey(name: 'Feature')
  String get feature;
  @override
  @JsonKey(name: 'Type')
  String get type;
  @override
  _$NextBusModelCopyWith<_NextBusModel> get copyWith;
}
