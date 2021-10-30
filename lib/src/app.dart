import 'package:flutter/material.dart';

import 'bus_stop/bus_stop_list_page.dart';
import 'bus_stop/bus_stop_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(),
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (context) {
            switch (routeSettings.name) {
              case BusStopListPage.routeName:
                return const BusStopListPage();
              case BusStopPage.routeName:
                final args = routeSettings.arguments! as Map<String, String>;
                return BusStopPage(
                  busStopCode: args['busStopCode']!,
                );
              default:
                return const BusStopListPage();
            }
          },
        );
      },
    );
  }
}
