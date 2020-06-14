import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/about/about_view.dart';
import 'package:lta_datamall_flutter/ui/views/app_drawer/app_drawer_viewmodel.dart';
import 'package:stacked/stacked.dart';

class AppDrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppDrawerViewModel>.nonReactive(
      builder: (contect, model, child) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildDrawerHeader(),
            for (var item in model.getActiveFeatures())
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
              applicationVersion: model.version,
              applicationLegalese: 'free | ad-free | open-source',
              applicationIcon: Icon(Icons.info_outline),
              aboutBoxChildren: <Widget>[AboutView()],
            ),
          ],
        ),
      ),
      viewModelBuilder: () => AppDrawerViewModel(),
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
