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
          _buildDrawerHeader(),
          ListTile(
            leading: Icon(Icons.directions_bus),
            title: Text('Buses'),
            onTap: () {
              ExtendedNavigator.of(context).pushNamed(Routes.busViewRoute);
            },
          ),
        ],
      ),
    );
  }

  DrawerHeader _buildDrawerHeader() {
    return DrawerHeader(
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
    );
  }
}
