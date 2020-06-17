import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:stacked/stacked.dart';

class BusNearbyViewModel extends FutureViewModel<List<BusStopModel>> {
  final _busService = locator<BusService>();
  final String _title = 'Nearby';
  String get title => _title;

  @override
  Future<List<BusStopModel>> futureToRun() => _busService.getNearbyBusStops();
}
