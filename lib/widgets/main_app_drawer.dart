import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/main.dart';
import 'package:lta_datamall_flutter/screens/bus_stops.dart';
import 'package:lta_datamall_flutter/screens/settings.dart';

class MainAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('What would you like to see?'),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Overview'),
            onTap: () {
              Navigator.pushNamed(context, Overview.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Bicycle Parking'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Bus Stops'),
            onTap: () {
              Navigator.pushNamed(context, BusStops.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Taxis'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, Settings.id);
            },
          ),
        ],
      ),
    );
  }
}
