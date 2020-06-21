// import 'package:stacked/stacked.dart';

// class BusNearbyViewModel extends BaseViewModel {
//   // static final _log = Logger('BusService');
//   // final _busService = locator<BusService>();
//   // final _locationService = locator<LocationService>();

//   // List<BusStopModel> get nearByBusStops {
//   //   _log.info('Get nearByBusStops');
//   //   return _busService.nearbyBusStops;
//   // }

//   // Future<void> initialize() async {
//   //   _locationService.locationStream.listen((userLocation) async {
//   //     await _busService.nearbyBusStopsByLocation(userLocation);
//   //     notifyListeners();
//   //   });
//   // }
// }

import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/location_service.dart';
import 'package:stacked/stacked.dart';

class BusNearbyViewModel extends BaseViewModel {
  UserLocation get userLocation => _locationService.userLocation;
  final _locationService = locator<LocationService>();

  Future<void> initialize() async {
    notifyListeners();
  }
}
