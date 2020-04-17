import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';

class FavoriteBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BusFavoritesService busFavoritesService = BusFavoritesService();

    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Your Favorite Bus Stops',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        BusStopCardList(
          busStopList: busFavoritesService.getFavoriteBusStops(),
        ),
      ],
    );
  }
}
