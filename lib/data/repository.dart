import 'package:geolocator/geolocator.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';

abstract class Repository {
  Future<List<BusStopModel>> getBusStopListBySearchText(String searchText);
  Future<List<BusStopModel>> getBusStopListByPosition(Position position);
  Future<List<BusStopModel>> getBusStopList();
}
