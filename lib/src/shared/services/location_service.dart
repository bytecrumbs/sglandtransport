import 'dart:async';

import 'package:flutter/foundation.dart';
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

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }

    permission = await GeolocatorPlatform.instance.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await GeolocatorPlatform.instance.requestPermission();
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
    _read(loggerProvider).d('stopped location streams and controllers');
  }

  Stream<UserLocationModel> startLocationStream() {
    _read(loggerProvider).d('starting location stream');
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
