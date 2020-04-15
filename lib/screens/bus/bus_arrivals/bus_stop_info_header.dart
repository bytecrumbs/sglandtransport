import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_header.dart';
import 'package:lta_datamall_flutter/services/bus/favorites_service.dart';

class BusStopInfoHeader extends StatefulWidget {
  const BusStopInfoHeader({
    @required this.busStopCode,
    @required this.description,
    @required this.roadName,
  });

  final String busStopCode;
  final String description;
  final String roadName;

  @override
  _BusStopInfoHeaderState createState() => _BusStopInfoHeaderState();
}

class _BusStopInfoHeaderState extends State<BusStopInfoHeader> {
  bool isFavoriteBusStop = false;

  @override
  void initState() {
    super.initState();
    final BusFavoritesService favoritesService = BusFavoritesService();
    favoritesService.isFavoriteBusStop(widget.busStopCode).then((bool result) {
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
                  _toggleFavoriteBusStop(widget.busStopCode);
                },
                icon: isFavoriteBusStop
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
              ),
              title: Text('${widget.busStopCode} (${widget.description})'),
              subtitle: Text(widget.roadName),
            ),
          ),
        ],
      ),
    );
  }
}
