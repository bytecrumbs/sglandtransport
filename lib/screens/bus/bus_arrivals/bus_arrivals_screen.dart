import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card_list.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_stop_info_header.dart';

class BusArrivalsScreen extends StatelessWidget {
  const BusArrivalsScreen({@required this.busStopModel});

  static const String id = 'bus_arrivals_screen';

  final BusStopModel busStopModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Arrivals'),
      ),
      body: Column(
        children: <Widget>[
          BusStopInfoHeader(busStopModel: busStopModel),
          Expanded(
            child: BusArrivalCardList(
              busStopCode: busStopModel.busStopCode,
            ),
          )
        ],
      ),
    );
  }
}
