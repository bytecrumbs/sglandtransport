import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/models/user_location.dart';

class NearbyBusStopsProvider with ChangeNotifier {
  NearbyBusStopsProvider({@required this.allBusStops});

  final List<BusStopModel> allBusStops;

  List<BusStopModel> getNearbyBusStops(UserLocation userLocation) {
    final nearbyBusStops = <BusStopModel>[];
    final distance = Distance();
    for (final busStop in allBusStops) {
      final distanceInMeters = distance(
        LatLng(userLocation.latitude, userLocation.longitude),
        LatLng(busStop.latitude, busStop.longitude),
      );

      final isNearby = distanceInMeters <= 500;

      if (isNearby) {
        busStop.distanceInMeters = distanceInMeters.round();
        nearbyBusStops.add(busStop);
      }
    }
    nearbyBusStops.sort((BusStopModel a, BusStopModel b) =>
        a.distanceInMeters.compareTo(b.distanceInMeters));

    return nearbyBusStops;
  }
}
