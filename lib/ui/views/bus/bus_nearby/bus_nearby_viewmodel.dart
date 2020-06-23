import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/location_service.dart';
import 'package:stacked/stacked.dart';

class BusNearbyViewModel extends FutureViewModel<UserLocation> {
  static final _log = Logger('BusNearbyViewModel');
  final _locationService = locator<LocationService>();

  @override
  Future<UserLocation> futureToRun() {
    _log.info('calling get user location');
    return _locationService.getUserLocation();
  }
}
