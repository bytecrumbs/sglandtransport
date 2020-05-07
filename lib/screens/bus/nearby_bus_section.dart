import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geohash/geohash.dart';
import 'package:geolocator/geolocator.dart';

import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';
import 'package:lta_datamall_flutter/services/bus/nearby_bus_stops_service_provider.dart';
import 'package:provider/provider.dart';

class NearbyBusStops extends StatefulWidget {
  @override
  _NearbyBusStopsState createState() => _NearbyBusStopsState();
}

class _NearbyBusStopsState extends State<NearbyBusStops> {
  StreamSubscription<Position> _positionStreamSubscription;
  String _geoHashCoordinates = '';
  List<BusStopModel> busStopList = <BusStopModel>[];
  final Geolocator geolocator = Geolocator();
  final LocationOptions locationOptions = LocationOptions(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
  );

  @override
  void initState() {
    _positionStreamSubscription =
        geolocator.getPositionStream(locationOptions).listen(
      (Position position) {
        final newGeoHashCoordinates =
            Geohash.encode(position.latitude, position.longitude)
                .substring(0, 8);
        if (newGeoHashCoordinates != _geoHashCoordinates) {
          context
              .read<NearbyBusStopsServiceProvider>()
              .setNearbyBusStop(position);
          _geoHashCoordinates = newGeoHashCoordinates;
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final busStopList =
        context.watch<NearbyBusStopsServiceProvider>().nearbyBusStops;
    if (busStopList.isNotEmpty) {
      return BusStopCardList(
        busStopList: busStopList,
      );
    } else {
      return Container();
    }
  }
}
