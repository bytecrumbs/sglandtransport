import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen.dart';

class BusStopCard extends StatelessWidget {
  const BusStopCard({
    @required this.busStopModel,
  });

  final BusStopModel busStopModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: ListTile(
        leading: Icon(Icons.departure_board),
        title: Text('${busStopModel.busStopCode} (${busStopModel.roadName})'),
        subtitle: Text(busStopModel.description),
        trailing: Icon(Icons.assignment),
        onTap: () {
          Navigator.pushNamed(
            context,
            BusArrivalsScreen.id,
            arguments: busStopModel,
          );
        },
      ),
    );
  }
}
