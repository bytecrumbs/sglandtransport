import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';
import 'package:provider/provider.dart';

class FavoriteBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BusStopCardList(
      busStopList: Provider.of<BusFavoritesService>(context).favoriteBusStops,
    );
  }
}
