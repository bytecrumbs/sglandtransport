import 'dart:html';

import 'package:lta_datamall_flutter/src/nearby/location_service.dart';

class LocationController {
  LocationController(this._locationService);

  final LocationService _locationService;

  late bool _serviceEnabled;

  PermissionStatus? _permissionGranted;

  Future<void> isLocationServiceEnabled() async {
    _serviceEnabled = await _locationService.serviceEnabled();
  }
}
