import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';

class NearbyBusStopsServiceProvider with ChangeNotifier {
  NearbyBusStopsServiceProvider({@required this.allBusStops});

  final List<BusStopModel> allBusStops;

  List<BusStopModel> _nearbyBusStops = <BusStopModel>[];
  List<BusStopModel> get nearbyBusStops => _nearbyBusStops;

  Future<void> setNearbyBusStop(LocationData currentLocation) async {
    _nearbyBusStops = <BusStopModel>[];
    final distance = Distance();
    for (final busStop in allBusStops) {
      final distanceInMeters = distance(
        LatLng(currentLocation.latitude, currentLocation.longitude),
        LatLng(busStop.latitude, busStop.longitude),
      );

      final isNearby = distanceInMeters <= 500;

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
