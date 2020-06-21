import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/location_service.dart';
import 'package:stacked/stacked.dart';

class BusNearbyViewModel extends BaseViewModel {
  static final _log = Logger('BaseViewModel');
  UserLocation get userLocation {
    _log.info(
        '::BaseViewModel - Getter userLocation  ${_locationService.userLocation.permissionGranted}');
    return _locationService.userLocation;
  }

  final _locationService = locator<LocationService>();

  Future<void> initialize() async {
    notifyListeners();
  }
}
