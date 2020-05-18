import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:lta_datamall_flutter/screens/about/main_about_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/main_bus_screen.dart';

// see https://pub.dev/packages/auto_route

@MaterialAutoRouter()
class $Router {
  @initial
  MainBusScreen mainBusScreenRoute;
  @CustomRoute(
    transitionsBuilder: TransitionsBuilders.zoomIn,
    durationInMilliseconds: 200,
  )
  BusArrivalsScreen busArrivalsScreenRoute;
  MainAboutScreen aboutScreenRoute;
}
