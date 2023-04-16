import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'location_service.dart';

class FakeLocationService implements LocationService {
  @override
  Ref<Object?> get ref => throw UnimplementedError();

  StreamController<UserLocationModel>? _locationController;

  UserLocationModel userLocationModel = UserLocationModel(
    latitude: 1.29685,
    longitude: 103.853,
  );

  @override
  Future<UserLocationModel> getCurrentPosition() {
    return Future.value(userLocationModel);
  }

  @override
  double getDistanceInMeters({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  @override
  Future<UserLocationModel> getLastKnownPosition() {
    return Future.value(userLocationModel);
  }

  @override
  Future<bool> handlePermission() {
    return Future.value(true);
  }

  @override
  Stream<UserLocationModel> startLocationStream() {
    _locationController = StreamController<UserLocationModel>();
    _locationController!.add(
      userLocationModel,
    );

    return _locationController!.stream.asBroadcastStream();
  }

  @override
  void stopLocationStream() {
    _locationController?.close();
  }
}
