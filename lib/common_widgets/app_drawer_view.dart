import 'dart:io';

import 'package:share/share.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app/about_view.dart';
import '../constants.dart';
import '../routing/router.gr.dart';

/// The main app drawer that is shown throughout the app
class AppDrawerView extends StatelessWidget {
  /// Default constructor
  const AppDrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          ListTile(
            leading: const Icon(Icons.directions_bus),
            title: const Text('Buses'),
            onTap: () {
              context.router.push(const BusStopViewRoute());
            },
          ),
          const AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationName: 'SG Land Transport',
            applicationVersion: Constants.currentVersion,
            applicationLegalese: 'free | ad-free | open-source',
            applicationIcon: Icon(Icons.info_outline),
            aboutBoxChildren: <Widget>[AboutView()],
          ),
          ListTile(
            leading: Icon(Platform.isAndroid ? Icons.share : Icons.ios_share),
            title: const Text('Share'),
            onTap: () async {
              await Share.share(
                'Check out SG Land Transport here: https://sglandtransport.app',
                subject: 'SG Land Transport',
              );
            },
          ),
        ],
      ),
    );
  }
}
