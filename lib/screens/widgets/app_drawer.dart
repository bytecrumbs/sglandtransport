import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var availableFeatures = Features().getListOfFeatures();
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
                  'Welcome to the SG Land Transport',
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
          for (var item in availableFeatures)
            ListTile(
              leading: item.icon,
              title: Text(item.title),
              onTap: () {
                ExtendedNavigator.of(context).pushNamed(item.routeName);
              },
            ),
        ],
      ),
    );
  }
}
