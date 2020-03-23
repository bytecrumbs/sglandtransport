import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus_stops.dart';
import 'package:lta_datamall_flutter/screens/settings.dart';

class Overview extends StatelessWidget {
  static const String id = 'overview_screen';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.directions_bike),
                iconSize: 70,
                onPressed: () {
                  print('Bicycle');
                },
              ),
              IconButton(
                icon: Icon(Icons.directions_bus),
                iconSize: 70,
                onPressed: () {
                  Navigator.pushNamed(context, BusStops.id);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.local_taxi),
                iconSize: 70,
                onPressed: () {
                  print('Navigate to Taxi');
                },
              ),
              IconButton(
                icon: Icon(Icons.settings),
                iconSize: 70,
                onPressed: () {
                  Navigator.pushNamed(context, Settings.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
