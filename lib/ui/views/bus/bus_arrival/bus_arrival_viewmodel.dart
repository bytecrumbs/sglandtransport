import 'dart:async';

import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:stacked/stacked.dart';

class BusArrivalViewModel extends BaseViewModel {
  static final _log = Logger('BusArrivalViewModel');
  final _busService = locator<BusService>();
  List<BusArrivalServiceModel> _busArrivalList = [];
  List<BusArrivalServiceModel> get busArrivalList => _busArrivalList;
  Timer _timer;

  Future<void> initialise(String busStopCode) async {
    _log.info('initializing ViewModel');
    await setBusArrivalList(busStopCode);
    _log.info('Setting timer');
    _timer = Timer.periodic(
      Duration(minutes: 1),
      (Timer timer) => setBusArrivalList(busStopCode),
    );
  }

  Future<void> setBusArrivalList(String busStopCode) async {
    _log.info('setting bus arrival list for bus stop $busStopCode');
    _busArrivalList = await _busService.getBusArrivalServices(busStopCode);
    notifyListeners();
  }

  @override
  void dispose() {
    _log.info('Cancelling timer');
    _timer.cancel();
    super.dispose();
  }
}
