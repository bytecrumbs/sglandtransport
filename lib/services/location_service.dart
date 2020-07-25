import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/environment_config.dart';

@lazySingleton
class LocationService {
  static final _log = Logger('LocationService');
  final _location = Location();

  StreamSubscription<LocationData> _locationSubscription;

  final StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<void> enableLocationStream() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    // If a UI test is run, do not use a location stream, but use a hardcoded
    // latitude and altitude
    if (EnvironmentConfig.isFlutterDriveRun) {
      _locationController.add(
        UserLocation(
          latitude: 1.29685,
          longitude: 103.853,
          permissionGranted: true,
        ),
      );
    } else {
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      _log.info('Start to listen to location stream');

      _locationSubscription =
          _location.onLocationChanged.handleError((dynamic err) {
        _log.severe('Error in location Stream: ${err.code}');
        _locationSubscription.cancel();
      }).listen(
        (locationData) {
          _log.info('Getting a new location');
          if (locationData != null) {
            _locationController.add(
              UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude,
                permissionGranted: true,
              ),
            );
          }
        },
      );
    }
  }

  Future<void> cancelLocationStream() async {
    _log.info('Cancelling the location stream');
    await _locationSubscription.cancel();
  }
}
