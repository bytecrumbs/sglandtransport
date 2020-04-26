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
      final double distanceInMeters = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          busStop.latitude,
          busStop.longitude);
      final bool isNearby = distanceInMeters <= 500;

      if (isNearby) {
        busStop.distanceInMeters = distanceInMeters.round();
        searchResult.add(busStop);
      }
    }
    _nearbyBusStops = searchResult;
    _nearbyBusStops.sort((BusStopModel a, BusStopModel b) =>
        a.distanceInMeters.compareTo(b.distanceInMeters));
    notifyListeners();
  }

  Future<void> _fetchAllBusStops() async {
    if (_allBusStops.isEmpty) {
      _allBusStops = await fetchBusStopList(http.IOClient());
    }
  }
}
