// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_view.dart';

abstract class Routes {
  static const busViewRoute = '/';
  static const all = {
    busViewRoute,
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
    switch (settings.name) {
      case Routes.busViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => BusView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
