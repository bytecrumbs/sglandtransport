import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../about/about_view.dart';
import '../shared/environment_config.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

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
            onTap: () {},
          ),
          AboutListTile(
            icon: const Icon(Icons.info_outline),
            applicationName: 'SG Land Transport',
            applicationVersion:
                '${EnvironmentConfig.buildName} - ${EnvironmentConfig.buildNumber.toString()}',
            applicationLegalese: 'free | ad-free | open-source',
            applicationIcon: const Icon(Icons.info_outline),
            aboutBoxChildren: const <Widget>[AboutView()],
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
