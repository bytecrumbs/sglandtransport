import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:stacked/stacked.dart';

class BusStopsViewModel extends BaseViewModel {
  List<BusStopModel> _busStopList;
  List<BusStopModel> get busStopList => _busStopList;

  Future<void> initialize(List<BusStopModel> busStopList) async {
    _busStopList = busStopList;
    notifyListeners();
  }
}
