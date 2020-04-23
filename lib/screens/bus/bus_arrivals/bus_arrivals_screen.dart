import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card_list.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';
import 'package:provider/provider.dart';

class BusArrivalsScreen extends StatelessWidget {
  const BusArrivalsScreen({@required this.busStopModel});

  static const String id = 'bus_arrivals_screen';

  final BusStopModel busStopModel;

  Future<void> _isFavoriteBusStop(
      BuildContext context, BusStopModel busStopModel) async {
    await Provider.of<BusFavoritesService>(context, listen: false)
        .setIsFavoriteBusStop(busStopModel);
  }

  @override
  Widget build(BuildContext context) {
    _isFavoriteBusStop(context, busStopModel);
    return Scaffold(
      appBar: AppBar(
        title: Text('${busStopModel.busStopCode} (${busStopModel.roadName})'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              key: const ValueKey<String>('favoriteIconButton'),
              onPressed: () {
                Provider.of<BusFavoritesService>(context, listen: false)
                    .toggleFavoriteBusStop(busStopModel);
              },
              icon: Provider.of<BusFavoritesService>(context).isFavoriteBusStop
                  ? Icon(
                      Icons.favorite,
                      key: const ValueKey<String>('favoriteIconSelected'),
                    )
                  : Icon(
                      Icons.favorite_border,
                      key: const ValueKey<String>('favoriteIconUnselected'),
                    ),
            ),
          ),
        ],
      ),
      body: BusArrivalCardList(
        busStopCode: busStopModel.busStopCode,
      ),
    );
  }
}
