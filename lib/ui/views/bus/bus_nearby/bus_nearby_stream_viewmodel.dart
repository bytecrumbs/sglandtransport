import 'package:location/location.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:stacked/stacked.dart';

class BusNearByStreamViewModel extends StreamViewModel {
  Location location = Location();
  final _busService = locator<BusService>();
  UserLocation _userLocation = UserLocation();
  List<BusStopModel> busStopList = [];

  List<BusStopModel> get currentLocation {
    // print('=====--------------------------============ $busStopList');
    return busStopList;
  }

  @override
  void initialise() {
    super.initialise();
    setLocationDataStream();
  }

  Future<void> setLocationDataStream() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  void onData(data) {
    print('This is called before get called =========  $data');
    setNearByBusStops(data);
    super.onData(data);
  }

  Future<void> setNearByBusStops(LocationData locationData) async {
    if (_userLocation.latitude != locationData.latitude) {
      _userLocation = UserLocation(
        latitude: data.latitude,
        longitude: data.longitude,
        permissionGranted: true,
      );
      busStopList =
          await _busService.getNearbyBusStopsByLocation(_userLocation);
      print('Before ------------Super ---- =========  $busStopList');
    }

    notifyListeners();
  }

  @override
  Stream<LocationData> get stream => location.onLocationChanged;

  @override
  void dispose() {
    super.dispose();
  }
}
