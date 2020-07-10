import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/location_service.dart';
import 'package:stacked/stacked.dart';

class BusNearByViewModel extends StreamViewModel {
  static final _log = Logger('BusNearByStreamViewModel');
  List<BusStopModel> _nearByBusStopList = [];
  final _busService = locator<BusService>();
  final _locationService = locator<LocationService>();

  List<BusStopModel> get nearByBusStopList => _nearByBusStopList;

  Future<void> setNearByBusStops(UserLocation userLocation) async {
    _nearByBusStopList =
        await _busService.getNearbyBusStopsByLocation(userLocation);
    _log.info('GET NEARBY BUS STOPS BY LOCATION $_nearByBusStopList');

    notifyListeners();
  }

  @override
  void initialise() {
    super.initialise();
    _locationService.enableLocationStream();
  }

  @override
  void onData(data) {
    _log.info('ON DATA CALLED WITH UPDATED LOCATION RETURN BY STREAM $data');
    setNearByBusStops(data);
    super.onData(data);
  }

  @override
  Stream<UserLocation> get stream => _locationService.locationStream;

  @override
  void dispose() {
    _locationService.cancelLocationStream();
    super.dispose();
  }
}
