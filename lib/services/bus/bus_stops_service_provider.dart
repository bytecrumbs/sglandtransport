import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lta_datamall_flutter/api.dart';
import 'package:http/io_client.dart' as http;
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';

class BusStopsServiceProvider with ChangeNotifier {
  List<BusStopModel> _allBusStops = <BusStopModel>[];
  List<BusStopModel> _nearbyBusStops = <BusStopModel>[];
  List<BusStopModel> get nearbyBusStops => _nearbyBusStops;

  Future<void> setNearbyBusStop(Position position) async {
    await _fetchAllBusStops();
    final List<BusStopModel> searchResult = <BusStopModel>[];
    for (final BusStopModel busStop in _allBusStops) {
      final bool isNearby = await Geolocator().distanceBetween(
              position.latitude,
              position.longitude,
              busStop.latitude,
              busStop.longitude) <=
          200;

      if (isNearby) {
        searchResult.add(busStop);
      }
      _nearbyBusStops = searchResult;
      notifyListeners();
    }
  }

  Future<void> _fetchAllBusStops() async {
    if (_allBusStops.isEmpty) {
      _allBusStops = await fetchBusStopList(http.IOClient());
    }
  }
}
