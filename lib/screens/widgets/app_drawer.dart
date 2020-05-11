import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Stack(children: <Widget>[
              Positioned(
                bottom: 12.0,
                left: 20.0,
                child: Text(
                  'Welcome to the LTA Datamall App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ]),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/icon.jpg'),
                fit: BoxFit.fill,
              ),
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
