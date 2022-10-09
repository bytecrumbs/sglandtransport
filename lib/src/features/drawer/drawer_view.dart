import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/environment_config.dart';
import '../../features/about/about_view.dart';
import '../../shared/services/rate_app_service.dart';

class DrawerView extends ConsumerWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rateAppService = ref.watch(rateAppServiceProvider);

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
          const AboutListTile(
            icon: Icon(Icons.info_outline),
            applicationName: 'SG Land Transport',
            applicationVersion: EnvironmentConfig.buildName,
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
          ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text('Rate SG Land Transport'),
            onTap: () async {
              await rateAppService.requestReview(force: true);
            },
          ),
        ],
      ),
    );
  }
}
