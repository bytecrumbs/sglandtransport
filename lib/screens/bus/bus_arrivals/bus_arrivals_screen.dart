import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card_list.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';

class BusArrivalsScreen extends StatefulWidget {
  const BusArrivalsScreen({@required this.busStopModel});

  static const String id = 'bus_arrivals_screen';

  final BusStopModel busStopModel;

  @override
  _BusArrivalsScreenState createState() => _BusArrivalsScreenState();
}

class _BusArrivalsScreenState extends State<BusArrivalsScreen> {
  bool isFavoriteBusStop = false;

  @override
  void initState() {
    super.initState();
    final BusFavoritesService favoritesService = BusFavoritesService();
    favoritesService.isFavoriteBusStop(widget.busStopModel).then((bool result) {
      setState(() => isFavoriteBusStop = result);
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.busStopModel.busStopCode} (${widget.busStopModel.roadName})'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              key: const ValueKey<String>('favoriteIconButton'),
              onPressed: () {
                _toggleFavoriteBusStop(widget.busStopModel);
              },
              icon: isFavoriteBusStop
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
        busStopCode: widget.busStopModel.busStopCode,
      ),
    );
  }
}
