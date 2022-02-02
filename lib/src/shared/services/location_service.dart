import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common_providers.dart';

part 'location_service.freezed.dart';

final locationServiceProvider = Provider((ref) => LocationService(ref.read));

class LocationService {
  LocationService(this._read);

  final Reader _read;

  StreamSubscription<Position>? _geolocatorStream;
  StreamController<UserLocationModel>? _locationController;

  void stopLocationStream() {
    _locationController?.close();
    _geolocatorStream?.cancel();
    _read(loggerProvider).d('stopped location streams and controllers');
  }

  Stream<UserLocationModel> startLocationStream() {
    _read(loggerProvider).d('starting location stream');
    _locationController = StreamController<UserLocationModel>();
    _geolocatorStream = Geolocator.getPositionStream(
      intervalDuration: const Duration(seconds: 1),
      distanceFilter: 5,
    ).listen((position) async {
      _read(loggerProvider).d('adding new position');
      _locationController!.add(
        UserLocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    });
    return _locationController!.stream.asBroadcastStream();
  }
}

@freezed
class UserLocationModel with _$UserLocationModel {
  factory UserLocationModel({
    required double latitude,
    required double longitude,
  }) = _UserLocationModel;
}
