import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/datamodels/user_location.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:stacked/stacked.dart';

class BusNearbyViewModel extends FutureViewModel<List<BusStopModel>> {
  final _busService = locator<BusService>();
  final String _title = 'Nearby';
  String get title => _title;
  final userLocation = UserLocation(latitude: 1.29785, longitude: 103.853);

  @override
  Future<List<BusStopModel>> futureToRun() =>
      _busService.getNearbyBusStopsByLocation(userLocation);
}
