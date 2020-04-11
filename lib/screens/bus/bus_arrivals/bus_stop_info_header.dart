import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_header.dart';

class BusStopInfoHeader extends StatelessWidget {
  const BusStopInfoHeader({
    @required this.busStopCode,
    @required this.description,
    @required this.roadName,
  });

  final String busStopCode;
  final String description;
  final String roadName;

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
              title: Text('$busStopCode ($description)'),
              subtitle: Text(roadName),
            ),
          ),
        ],
      ),
    );
  }
}
