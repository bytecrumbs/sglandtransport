// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_view.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_arrival/bus_arrival_view.dart';
import 'package:lta_datamall_flutter/ui/views/iap/purchase.dart';

abstract class Routes {
  static const busViewRoute = '/';
  static const busArrivalView = '/bus-arrival-view';
  static const marketScreen = '/market-screen';
  static const all = {
    busViewRoute,
    busArrivalView,
    marketScreen,
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
      case Routes.busViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => BusView(),
          settings: settings,
        );
      case Routes.busArrivalView:
        if (hasInvalidArgs<BusArrivalViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<BusArrivalViewArguments>(args);
        }
        final typedArgs = args as BusArrivalViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => BusArrivalView(
              busStopCode: typedArgs.busStopCode,
              description: typedArgs.description),
          settings: settings,
        );
      case Routes.marketScreen:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MarketScreen(),
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

//BusArrivalView arguments holder class
class BusArrivalViewArguments {
  final String busStopCode;
  final String description;
  BusArrivalViewArguments(
      {@required this.busStopCode, @required this.description});
}
