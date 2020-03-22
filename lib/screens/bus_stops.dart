import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/overview.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals.dart';

class BusStops extends StatelessWidget {
  static const String id = 'bus_stops_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.apps),
          onPressed: () {
            Navigator.pushNamed(context, Overview.id);
          },
        ),
        title: const Text('Bus Stops'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('434343'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, BusArrivals.id);
            },
          ),
          ListTile(
            title: const Text('343434'),
            trailing: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}
