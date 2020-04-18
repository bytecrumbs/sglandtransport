import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card_list.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';

Future<List<BusStopModel>> _getFavoriteBusStops() {
  final BusFavoritesService busFavoritesService = BusFavoritesService();
  return busFavoritesService.getFavoriteBusStops();
}

class FavoriteBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        FutureBuilder<List<BusStopModel>>(
          future: _getFavoriteBusStops(),
          builder: (BuildContext context,
              AsyncSnapshot<List<BusStopModel>> snapshot) {
            if (snapshot.hasData) {
              return BusStopCardList(
                busStopList: snapshot.data,
              );
            } else if (snapshot.hasError) {
              // TODO(anyone): Do something here...
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
      ],
    );
  }
}
