import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';

class BusStopCard extends StatelessWidget {
  const BusStopCard({
    @required this.openContainer,
    @required this.busStopModel,
  });

  final Function() openContainer;
  final BusStopModel busStopModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: ListTile(
        leading: Icon(Icons.departure_board),
        onTap: openContainer,
        title: Text('${busStopModel.busStopCode} (${busStopModel.roadName})'),
        subtitle: Text(busStopModel.description),
        trailing: Icon(Icons.assignment),
      ),
    );
  }
}
