import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bicycle/main_bicycle_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/main_bus_screen.dart';
import 'package:lta_datamall_flutter/screens/car/main_car_screen.dart';
import 'package:lta_datamall_flutter/screens/settings/main_settings_screen.dart';
import 'package:lta_datamall_flutter/screens/taxi/main_taxi_screen.dart';
import 'package:lta_datamall_flutter/screens/traffic/main_traffic_screen.dart';
import 'package:lta_datamall_flutter/screens/train/main_train_screen.dart';

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
            title: const Text('Buses'),
            onTap: () {
              Navigator.pushNamed(context, MainBusScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.train),
            title: const Text('Trains'),
            onTap: () {
              Navigator.pushNamed(context, MainTrainScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_bike),
            title: const Text('Bicycles'),
            onTap: () {
              Navigator.pushNamed(context, MainBicycleScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: const Text('Cars'),
            onTap: () {
              Navigator.pushNamed(context, MainCarScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_taxi),
            title: const Text('Taxis'),
            onTap: () {
              Navigator.pushNamed(context, MainTaxiScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.traffic),
            title: const Text('Traffic'),
            onTap: () {
              Navigator.pushNamed(context, MainTrafficScreen.id);
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
