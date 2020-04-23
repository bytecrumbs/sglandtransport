import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:lta_datamall_flutter/data/bus_stop_list_repository.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';

class NearbyBusStops extends StatefulWidget {
  @override
  _NearbyBusStopsState createState() => _NearbyBusStopsState();
}

class _NearbyBusStopsState extends State<NearbyBusStops> {
  static final BusStopListRepository _repo = BusStopListRepository();
  StreamSubscription<Position> positionStream;
  List<BusStopModel> busStopList = <BusStopModel>[];

  @override
  void initState() {
    final Geolocator geolocator = Geolocator();
    final LocationOptions locationOptions = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    positionStream = geolocator.getPositionStream(locationOptions).listen(
      (Position position) {
        _repo
            .getBusStopListByPosition(position)
            .then((List<BusStopModel> result) {
          setState(() {
            busStopList = result;
          });
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  // Future<List<BusStopModel>> _fetchBusStopList() {
  //   return NearbyBusStops._repo.getBusStopList();
  // }

  @override
  Widget build(BuildContext context) {
    if (busStopList.isNotEmpty) {
      return BusStopCardList(
        busStopList: busStopList,
      );
    } else {
      return const Center(
        child: Text('Looking for nearby Bus Stops...'),
      );
    }
  }
}
