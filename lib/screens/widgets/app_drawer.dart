import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bicycle/main_bicycle_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/main_bus_screen.dart';
import 'package:lta_datamall_flutter/screens/settings/main_settings_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: const Text(
              'Welcome to the LTA Datamall App',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.directions_bus),
            title: const Text('Bus Timing'),
            onTap: () {
              Navigator.pushNamed(context, MainBusScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_bike),
            title: const Text('Bicycle Parking'),
            onTap: () {
              Navigator.pushNamed(context, MainBicycleScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, MainSettingsScreen.id);
            },
          ),
        ],
      ),
    );
  }
}
