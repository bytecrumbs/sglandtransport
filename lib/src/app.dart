import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/src/arrival/bus_arrival_screen_arguments.dart';
import 'arrival/bus_arrival_controller.dart';
import 'arrival/bus_arrival_list_view.dart';
import 'nearby/bus_stop_list_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.busArrivalController,
  }) : super(key: key);

  final BusArrivalController busArrivalController;

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
              case BusStopListView.routeName:
                return const BusStopListView();
              case BusArrivalListView.routeName:
                final args = routeSettings.arguments! as Map<String, String>;
                return BusArrivalListView(
                  controller: busArrivalController,
                  busStopNumber: args['busStopNumber']!,
                );
              default:
                return const BusStopListView();
            }
          },
        );
      },
    );
  }
}
