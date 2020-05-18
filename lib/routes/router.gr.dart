// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lta_datamall_flutter/screens/bus/main_bus_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/about/main_about_screen.dart';

abstract class Routes {
  static const mainBusScreenRoute = '/';
  static const busArrivalsScreenRoute = '/bus-arrivals-screen-route';
  static const aboutScreenRoute = '/about-screen-route';
  static const all = {
    mainBusScreenRoute,
    busArrivalsScreenRoute,
    aboutScreenRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.mainBusScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MainBusScreen(),
          settings: settings,
        );
      case Routes.busArrivalsScreenRoute:
        if (hasInvalidArgs<BusArrivalsScreenArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<BusArrivalsScreenArguments>(args);
        }
        final typedArgs = args as BusArrivalsScreenArguments;
        return PageRouteBuilder<dynamic>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              BusArrivalsScreen(busStopModel: typedArgs.busStopModel),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
          transitionDuration: const Duration(milliseconds: 200),
        );
      case Routes.aboutScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MainAboutScreen(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//BusArrivalsScreen arguments holder class
class BusArrivalsScreenArguments {
  final BusStopModel busStopModel;
  BusArrivalsScreenArguments({@required this.busStopModel});
}
