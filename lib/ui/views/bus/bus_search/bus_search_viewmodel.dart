import 'dart:async';

import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:stacked/stacked.dart';

class BusSearchViewModel extends BaseViewModel {
  static final _log = Logger('BusArrivalViewModel');
  final _busService = locator<BusService>();
  List<BusStopModel> _busStopSearchList = <BusStopModel>[];

  List<BusStopModel> get busStopSearchList => _busStopSearchList;

  Future<void> onSearchTextChanged(String value) async {
    _log.info('calling search');
    _busStopSearchList = await _busService.findBusStops(value);
    notifyListeners();
  }
}
