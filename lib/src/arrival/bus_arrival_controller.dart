import 'package:flutter/material.dart';
import 'bus_arrival_service.dart';

class BusArrivalController with ChangeNotifier {
  BusArrivalController(this._busArrivalService);

  final BusArrivalService _busArrivalService;

  List<String>? _busNumbers;

  List<String>? get busNumbers => _busNumbers;

  Future<void> init(String busStopNumber) async {
    _busNumbers = await _busArrivalService.getBusArrivalInfo(busStopNumber);
    notifyListeners();
  }

  void reset() {
    _busNumbers = null;
    notifyListeners();
  }
}
