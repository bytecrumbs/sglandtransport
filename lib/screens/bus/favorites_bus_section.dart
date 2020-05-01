import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';
import 'package:lta_datamall_flutter/services/bus/favorite_bus_stops_service_provider.dart';
import 'package:provider/provider.dart';

class FavoriteBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BusStopCardList(
      busStopList: Provider.of<FavoriteBusStopsServiceProvider>(context)
          .favoriteBusStops,
    );
  }
}
