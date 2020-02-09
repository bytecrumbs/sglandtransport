import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/widgets/main_app_drawer.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals.dart';

class BusStops extends StatelessWidget {
  static const String id = 'bus_stops_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Stops'),
      ),
      drawer: MainAppDrawer(),
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
