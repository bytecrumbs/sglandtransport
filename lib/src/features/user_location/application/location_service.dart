import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../third_party_providers.dart';
import '../domain/user_location_model.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(LocationServiceRef ref) => LocationService(ref);

class LocationService {
  LocationService(this.ref);

  final Ref ref;

  StreamSubscription<Position>? _geolocatorStream;
  StreamController<UserLocationModel>? _locationController;

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }

  void stopLocationStream() {
    _locationController?.close();
    _geolocatorStream?.cancel();
    ref.read(loggerProvider).d('stopped location streams and controllers');
  }

  Stream<UserLocationModel> startLocationStream() {
    ref.read(loggerProvider).d('starting location stream');
    _locationController = StreamController<UserLocationModel>();

    late LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        distanceFilter: 5,
        intervalDuration: const Duration(seconds: 1),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        distanceFilter: 5,
        pauseLocationUpdatesAutomatically: true,
      );
    } else {
      locationSettings = const LocationSettings(
        distanceFilter: 5,
      );
    }

    _geolocatorStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((position) async {
      ref.read(loggerProvider).d('adding new position');
      _locationController!.add(
        UserLocationModel(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    });
    return _locationController!.stream.asBroadcastStream();
  }

  Future<UserLocationModel> getLastKnownPosition() async {
    final currentPosition = await Geolocator.getLastKnownPosition();
    return UserLocationModel(
      latitude: currentPosition?.latitude,
      longitude: currentPosition?.longitude,
    );
  }

  Future<UserLocationModel> getCurrentPosition() async {
    final permission = await handlePermission();
    if (permission) {
      final currentPosition = await Geolocator.getCurrentPosition();
      return UserLocationModel(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
      );
    } else {
      return UserLocationModel();
    }
  }

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
}
