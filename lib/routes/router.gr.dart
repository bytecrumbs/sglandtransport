// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:lta_datamall_flutter/screens/bus/main_bus_screen.dart';
import 'package:lta_datamall_flutter/screens/bicycle/main_bicycle_screen.dart';
import 'package:lta_datamall_flutter/screens/settings/main_settings_screen.dart';
import 'package:lta_datamall_flutter/screens/car/main_car_screen.dart';
import 'package:lta_datamall_flutter/screens/taxi/main_taxi_screen.dart';
import 'package:lta_datamall_flutter/screens/traffic/main_traffic_screen.dart';
import 'package:lta_datamall_flutter/screens/train/main_train_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/about/main_about_screen.dart';

abstract class Routes {
  static const mainBusScreenRoute = '/';
  static const mainBicycleScreenRoute = '/main-bicycle-screen-route';
  static const mainSettingsScreenRoute = '/main-settings-screen-route';
  static const mainCarScreenRoute = '/main-car-screen-route';
  static const mainTaxiScreenRoute = '/main-taxi-screen-route';
  static const mainTrafficScreenRoute = '/main-traffic-screen-route';
  static const mainTrainScreenRoute = '/main-train-screen-route';
  static const busArrivalsScreenRoute = '/bus-arrivals-screen-route';
  static const aboutScreenRoute = '/about-screen-route';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.mainBusScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainBusScreen(),
          settings: settings,
        );
      case Routes.mainBicycleScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainBicycleScreen(),
          settings: settings,
        );
      case Routes.mainSettingsScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainSettingsScreen(),
          settings: settings,
        );
      case Routes.mainCarScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainCarScreen(),
          settings: settings,
        );
      case Routes.mainTaxiScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainTaxiScreen(),
          settings: settings,
        );
      case Routes.mainTrafficScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainTrafficScreen(),
          settings: settings,
        );
      case Routes.mainTrainScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainTrainScreen(),
          settings: settings,
        );
      case Routes.busArrivalsScreenRoute:
        if (hasInvalidArgs<BusArrivalsScreenArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<BusArrivalsScreenArguments>(args);
        }
        final typedArgs = args as BusArrivalsScreenArguments;
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              BusArrivalsScreen(busStopModel: typedArgs.busStopModel),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
          transitionDuration: const Duration(milliseconds: 200),
        );
      case Routes.aboutScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => MainAboutScreen(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//BusArrivalsScreen arguments holder class
class BusArrivalsScreenArguments {
  final BusStopModel busStopModel;
  BusArrivalsScreenArguments({@required this.busStopModel});
}
