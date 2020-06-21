import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:stacked/stacked.dart';

class BusStopsViewModel extends FutureViewModel<List<BusStopModel>> {
  BusStopsViewModel(this.userLocation);
  static final _log = Logger('BusArrivalViewModel');
  final UserLocation userLocation;
  final _busService = locator<BusService>();

  @override
  Future<List<BusStopModel>> futureToRun() {
    _log.info('getting bus arrival list for bus stop $userLocation');
    return _busService.getNearbyBusStopsByLocation(userLocation);
  }
}
