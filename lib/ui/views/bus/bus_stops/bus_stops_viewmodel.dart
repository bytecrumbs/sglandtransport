import 'package:lta_datamall_flutter/datamodels/bus/bus_stop/bus_stop_model.dart';
import 'package:stacked/stacked.dart';

class BusStopsViewModel extends BaseViewModel {
  BusStopsViewModel(this.busStopList);
  final List<BusStopModel> busStopList;
}
