import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:stacked/stacked.dart';

class BusNearbyViewModel extends FutureViewModel<List<BusStopModel>> {
  static final _log = Logger('BusArrivalViewModel');
  final _busService = locator<BusService>();

  @override
  Future<List<BusStopModel>> futureToRun() {
    _log.info('Get nearby bus stops');
    return _busService.getNearbyBusStops();
  }
}
