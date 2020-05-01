import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';

class NearbyBusStopsServiceProvider with ChangeNotifier {
  NearbyBusStopsServiceProvider({@required this.allBusStops});

  final List<BusStopModel> allBusStops;

  List<BusStopModel> _nearbyBusStops = <BusStopModel>[];
  List<BusStopModel> get nearbyBusStops => _nearbyBusStops;

  Future<void> setNearbyBusStop(Position position) async {
    _nearbyBusStops = <BusStopModel>[];
    for (final BusStopModel busStop in allBusStops) {
      final double distanceInMeters = await Geolocator().distanceBetween(
          position.latitude,
          position.longitude,
          busStop.latitude,
          busStop.longitude);
      final bool isNearby = distanceInMeters <= 500;

      if (isNearby) {
        busStop.distanceInMeters = distanceInMeters.round();
        _nearbyBusStops.add(busStop);
      }
    }
    _nearbyBusStops.sort((BusStopModel a, BusStopModel b) =>
        a.distanceInMeters.compareTo(b.distanceInMeters));
    notifyListeners();
  }
}
