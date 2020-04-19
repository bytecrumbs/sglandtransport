import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bicycle/main_bicycle_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen_arguments.dart';
import 'package:lta_datamall_flutter/screens/bus/main_bus_screen.dart';
import 'package:lta_datamall_flutter/screens/car/main_car_screen.dart';
import 'package:lta_datamall_flutter/screens/settings/main_settings_screen.dart';
import 'package:lta_datamall_flutter/screens/taxi/main_taxi_screen.dart';
import 'package:lta_datamall_flutter/screens/traffic/main_traffic_screen.dart';
import 'package:lta_datamall_flutter/screens/train/main_train_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    final FirebaseAnalyticsObserver observer =
        FirebaseAnalyticsObserver(analytics: analytics);
    // Getting arguments passed in while calling Navigator.pushNamed
    final Object args = settings.arguments;

    switch (settings.name) {
      case MainBusScreen.id:
        return MaterialPageRoute<MainBusScreen>(
          builder: (_) => MainBusScreen(
            observer: observer,
          ),
        );
      case MainBicycleScreen.id:
        return MaterialPageRoute<MainBicycleScreen>(
          builder: (_) => MainBicycleScreen(),
        );
      case MainSettingsScreen.id:
        return MaterialPageRoute<MainSettingsScreen>(
          builder: (_) => MainSettingsScreen(),
        );
      case MainCarScreen.id:
        return MaterialPageRoute<MainCarScreen>(
          builder: (_) => MainCarScreen(),
        );
      case MainTaxiScreen.id:
        return MaterialPageRoute<MainTaxiScreen>(
          builder: (_) => MainTaxiScreen(),
        );
      case MainTrafficScreen.id:
        return MaterialPageRoute<MainTrafficScreen>(
          builder: (_) => MainTrafficScreen(),
        );
      case MainTrainScreen.id:
        return MaterialPageRoute<MainTrainScreen>(
          builder: (_) => MainTrainScreen(),
        );
      case BusArrivalsScreen.id:
        if (args is BusArrivalsScreenArguments) {
          final BusArrivalsScreenArguments screenArgs =
              settings.arguments as BusArrivalsScreenArguments;
          return MaterialPageRoute<BusArrivalsScreen>(
            builder: (_) => BusArrivalsScreen(
              busStopModel: screenArgs.busStopModel,
            ),
          );
        }
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<Scaffold>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
