import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_header.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';

class BusStopInfoHeader extends StatefulWidget {
  const BusStopInfoHeader({@required this.busStopModel});

  final BusStopModel busStopModel;

  @override
  _BusStopInfoHeaderState createState() => _BusStopInfoHeaderState();
}

class _BusStopInfoHeaderState extends State<BusStopInfoHeader> {
  bool isFavoriteBusStop = false;

  @override
  void initState() {
    super.initState();
    final BusFavoritesService favoritesService = BusFavoritesService();
    favoritesService
        .isFavoriteBusStop(widget.busStopModel.busStopCode)
        .then((bool result) {
      setState(() => isFavoriteBusStop = result);
    });
  }

  Future<void> _toggleFavoriteBusStop(String busStopCode) async {
    final BusFavoritesService favoritesService = BusFavoritesService();

    if (isFavoriteBusStop) {
      favoritesService.removeFavoriteBusStop(busStopCode);
    } else {
      favoritesService.addFavoriteBusStop(busStopCode);
    }
    setState(() {
      isFavoriteBusStop = !isFavoriteBusStop;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          const BusArrivalHeader(
            headerText: 'Bus Stop',
          ),
          Card(
            margin: const EdgeInsets.all(6),
            child: ListTile(
              trailing: IconButton(
                onPressed: () {
                  _toggleFavoriteBusStop(widget.busStopModel.busStopCode);
                },
                icon: isFavoriteBusStop
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
              ),
              title: Text(
                  '${widget.busStopModel.busStopCode} (${widget.busStopModel.description})'),
              subtitle: Text(widget.busStopModel.roadName),
            ),
          ),
        ],
      ),
    );
  }
}
