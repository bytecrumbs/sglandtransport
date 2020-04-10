import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals/bus_arrival_card_list.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals/bus_stop_info_header.dart';

class BusArrivalsScreen extends StatelessWidget {
  const BusArrivalsScreen({
    @required this.busStopCode,
    @required this.description,
    @required this.roadName,
  });

  static const String id = 'bus_arrivals_screen';

  final String busStopCode;
  final String description;
  final String roadName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Arrivals'),
      ),
      body: Column(
        children: <Widget>[
          BusStopInfoHeader(
            busStopCode: busStopCode,
            description: description,
            roadName: roadName,
          ),
          Expanded(
            child: BusArrivalCardList(
              busStopCode: busStopCode,
            ),
          )
        ],
      ),
    );
  }
}
