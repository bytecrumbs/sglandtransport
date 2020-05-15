import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card_list.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/favorite_button.dart';

class BusArrivalsScreen extends StatelessWidget {
  const BusArrivalsScreen({@required this.busStopModel});

  final BusStopModel busStopModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(busStopModel.description),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: FavoriteButton(busStopCode: busStopModel.busStopCode),
          ),
        ],
      ),
      body: BusArrivalCardList(
        busStopCode: busStopModel.busStopCode,
      ),
    );
  }
}
