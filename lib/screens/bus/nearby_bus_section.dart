import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';
import 'package:lta_datamall_flutter/services/bus/nearby_bus_stops_service_provider.dart';
import 'package:provider/provider.dart';

class NearbyBusStops extends StatefulWidget {
  @override
  _NearbyBusStopsState createState() => _NearbyBusStopsState();
}

class _NearbyBusStopsState extends State<NearbyBusStops> {
  StreamSubscription _positionStreamSubscription;
  List<BusStopModel> busStopList = <BusStopModel>[];
  Location location = Location();

  @override
  void initState() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        _positionStreamSubscription =
            location.onLocationChanged.listen((LocationData currentLocation) {
          context
              .read<NearbyBusStopsServiceProvider>()
              .setNearbyBusStop(currentLocation);
        });
      }
    });

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
