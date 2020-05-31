import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/features.dart';
import 'package:lta_datamall_flutter/screens/about/main_about_screen.dart';

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
                  'Welcome to SG Land Transport',
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
          AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationName: 'SG Land Transport',
            applicationVersion: '1.0.1',
            applicationLegalese: 'free | ad-free | open-source',
            applicationIcon: Icon(Icons.info_outline),
            aboutBoxChildren: <Widget>[MainAboutScreen()],
          ),
        ],
      ),
    );
  }
}
