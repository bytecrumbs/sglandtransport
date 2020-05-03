import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';

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
              ExtendedNavigator.of(context)
                  .pushNamed(Routes.mainBusScreenRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.train),
            title: const Text('Trains'),
            onTap: () {
              ExtendedNavigator.of(context)
                  .pushNamed(Routes.mainTrainScreenRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_bike),
            title: const Text('Bicycles'),
            onTap: () {
              ExtendedNavigator.of(context)
                  .pushNamed(Routes.mainBicycleScreenRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: const Text('Cars'),
            onTap: () {
              ExtendedNavigator.of(context)
                  .pushNamed(Routes.mainCarScreenRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_taxi),
            title: const Text('Taxis'),
            onTap: () {
              ExtendedNavigator.of(context)
                  .pushNamed(Routes.mainTaxiScreenRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.traffic),
            title: const Text('Traffic'),
            onTap: () {
              ExtendedNavigator.of(context)
                  .pushNamed(Routes.mainTrafficScreenRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              ExtendedNavigator.of(context).pushNamed(Routes.aboutScreenRoute);
            },
          ),
        ],
      ),
    );
  }
}
