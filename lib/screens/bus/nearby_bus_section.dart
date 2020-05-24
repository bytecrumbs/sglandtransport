import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/user_location.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';
import 'package:lta_datamall_flutter/providers/bus/nearby_bus_stops_provider.dart';
import 'package:provider/provider.dart';

class NearbyBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userLocation = Provider.of<UserLocation>(context);

    if (userLocation != null) {
      if (userLocation.permissionGranted) {
        final busStopList =
            Provider.of<NearbyBusStopsProvider>(context, listen: false)
                .getNearbyBusStops(userLocation);
        return BusStopCardList(
          busStopList: busStopList,
        );
      } else {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Text(
                'Please enable location services, so that we can show you nearby bus stops!'),
          ),
        );
      }
    } else {
      return Container();
    }
  }
}
