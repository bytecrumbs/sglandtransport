import 'package:flutter/material.dart';

import 'bus_stop/bus_stop_list_page_view.dart';
import 'bus_stop/bus_stop_page_view.dart';

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
              case BusStopListPageView.routeName:
                return const BusStopListPageView();
              case BusStopPageView.routeName:
                final args = routeSettings.arguments! as Map<String, String>;
                return BusStopPageView(
                  busStopCode: args['busStopCode']!,
                  description: args['description']!,
                );
              default:
                return const BusStopListPageView();
            }
          },
        );
      },
    );
  }
}
