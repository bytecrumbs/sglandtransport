import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus_stops.dart';
import 'package:lta_datamall_flutter/screens/overview.dart';
import 'package:lta_datamall_flutter/screens/settings.dart';

class MainAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text('What would you like to see?'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Overview'),
            onTap: () {
              Navigator.pushNamed(context, Overview.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_bike),
            title: const Text('Bicycle Parking'),
          ),
          ListTile(
            leading: Icon(Icons.directions_bus),
            title: const Text('Bus Stops'),
            onTap: () {
              Navigator.pushNamed(context, BusStops.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_taxi),
            title: const Text('Taxis'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, Settings.id);
            },
          ),
        ],
      ),
    );
  }
}
