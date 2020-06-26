import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:stacked/stacked.dart';

class BusArrivalViewModel
    extends FutureViewModel<List<BusArrivalServiceModel>> {
  BusArrivalViewModel(this.busStopCode);
  static final _log = Logger('BusArrivalViewModel');
  final String busStopCode;
  final _busService = locator<BusService>();

  @override
  Future<List<BusArrivalServiceModel>> futureToRun() {
    _log.info('getting bus arrival list for bus stop $busStopCode');
    return _busService.getBusArrivalServices(busStopCode);
  }
}
