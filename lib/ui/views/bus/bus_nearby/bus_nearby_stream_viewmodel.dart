import 'package:location/location.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/location_service.dart';
import 'package:stacked/stacked.dart';

class BusNearByStreamViewModel extends StreamViewModel {
  static final _log = Logger('BusNearByStreamViewModel');
  List<BusStopModel> _nearByBusStopList = [];
  final _busService = locator<BusService>();
  final _locationService = locator<LocationService>();
  UserLocation _userLocation = UserLocation();

  List<BusStopModel> get nearByBusStopList => _nearByBusStopList;

  Future<void> setNearByBusStops(LocationData locationData) async {
    if (_userLocation.latitude != locationData.latitude) {
      _userLocation = UserLocation(
        latitude: data.latitude,
        longitude: data.longitude,
        permissionGranted: true,
      );
      _nearByBusStopList =
          await _busService.getNearbyBusStopsByLocation(_userLocation);
      _log.info('GET NEARBY BUS STOPS BY LOCATION $_nearByBusStopList');
    }

    notifyListeners();
  }

  @override
  void initialise() {
    super.initialise();
    _locationService.enableLocationPermission();
  }

  @override
  void onData(data) {
    _log.info('ON DATA CALLED WITH UPDATED LOCATION RETURN BY STREAM $data');
    setNearByBusStops(data);
    super.onData(data);
  }

  @override
  Stream<LocationData> get stream => _locationService.onLocationChanged;

  @override
  void dispose() {
    super.dispose();
  }
}
