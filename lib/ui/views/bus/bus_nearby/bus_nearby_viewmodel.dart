import 'dart:async';

import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/location_service.dart';
import 'package:stacked/stacked.dart';

class BusNearByViewModel extends BaseViewModel {
  static final _log = Logger('BusNearByViewModel');
  List<BusStopModel> _nearByBusStopList = [];
  final _busService = locator<BusService>();
  final _locationService = locator<LocationService>();
  StreamSubscription<UserLocation> _locationSubscription;

  List<BusStopModel> get nearByBusStopList => _nearByBusStopList;

  void initialise() async {
    await _locationService.enableLocationStream();
    _locationSubscription =
        _locationService.locationStream.listen((userLocation) async {
      _log.info(
          'getting nearby bus stops for latitude ${userLocation.latitude} and longitude ${userLocation.longitude}');
      _nearByBusStopList =
          await _busService.getNearbyBusStopsByLocation(userLocation);
      _log.info('found ${_nearByBusStopList.length} nearby bus stops');

      notifyListeners();
    });
  }

  @override
  void dispose() async {
    _log.info('cancelling streams');
    await _locationSubscription.cancel();
    await _locationService.cancelLocationStream();
    super.dispose();
  }
}
