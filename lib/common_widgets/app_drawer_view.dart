import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app/about_view.dart';
import '../constants.dart';
import '../routing/router.gr.dart' as auto_route;

/// The main app drawer that is shown throughout the app
class AppDrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(Icons.directions_bus),
            title: Text('Buses'),
            onTap: () {
              ExtendedNavigator.root.push(auto_route.Routes.busStopView);
            },
          ),
          AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationName: 'SG Land Transport',
            applicationVersion: Constants.currentVersion,
            applicationLegalese: 'free | ad-free | open-source',
            applicationIcon: Icon(Icons.info_outline),
            aboutBoxChildren: <Widget>[AboutView()],
          ),
        ],
      ),
    );
  }
}
