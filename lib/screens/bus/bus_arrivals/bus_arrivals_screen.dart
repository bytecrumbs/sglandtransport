import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card_list.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen_arguments.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';

class BusArrivalsScreen extends StatefulWidget {
  static const String id = 'bus_arrivals_screen';

  @override
  _BusArrivalsScreenState createState() => _BusArrivalsScreenState();
}

class _BusArrivalsScreenState extends State<BusArrivalsScreen> {
  bool isFavoriteBusStop = false;

  Future<void> _toggleFavoriteBusStop(BusStopModel busStopModel) async {
    final BusFavoritesService favoritesService = BusFavoritesService();

    if (isFavoriteBusStop) {
      favoritesService.removeFavoriteBusStop(busStopModel);
    } else {
      favoritesService.addFavoriteBusStop(busStopModel);
    }
    setState(() {
      isFavoriteBusStop = !isFavoriteBusStop;
    });
  }

  @override
  Widget build(BuildContext context) {
    BusArrivalsScreenArguments args;
    if (ModalRoute.of(context).settings.arguments
        is BusArrivalsScreenArguments) {
      args = ModalRoute.of(context).settings.arguments
          as BusArrivalsScreenArguments;
    } else {
      // TODO(anyone): throw error if wrong arguments have been passed
    }

    final BusFavoritesService favoritesService = BusFavoritesService();
    favoritesService.isFavoriteBusStop(args.busStopModel).then((bool result) {
      setState(() {
        isFavoriteBusStop = result;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${args.busStopModel.busStopCode} (${args.busStopModel.roadName})'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                _toggleFavoriteBusStop(args.busStopModel);
              },
              icon: isFavoriteBusStop
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
      body: BusArrivalCardList(
        busStopCode: args.busStopModel.busStopCode,
      ),
    );
  }
}
