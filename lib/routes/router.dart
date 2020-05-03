import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:lta_datamall_flutter/screens/about/main_about_screen.dart';
import 'package:lta_datamall_flutter/screens/bicycle/main_bicycle_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrivals_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/main_bus_screen.dart';
import 'package:lta_datamall_flutter/screens/car/main_car_screen.dart';
import 'package:lta_datamall_flutter/screens/settings/main_settings_screen.dart';
import 'package:lta_datamall_flutter/screens/taxi/main_taxi_screen.dart';
import 'package:lta_datamall_flutter/screens/traffic/main_traffic_screen.dart';
import 'package:lta_datamall_flutter/screens/train/main_train_screen.dart';

// see https://pub.dev/packages/auto_route

@MaterialAutoRouter()
class $Router {
  @initial
  MainBusScreen mainBusScreenRoute;
  MainBicycleScreen mainBicycleScreenRoute;
  MainSettingsScreen mainSettingsScreenRoute;
  MainCarScreen mainCarScreenRoute;
  MainTaxiScreen mainTaxiScreenRoute;
  MainTrafficScreen mainTrafficScreenRoute;
  MainTrainScreen mainTrainScreenRoute;
  @CustomRoute(
    transitionsBuilder: TransitionsBuilders.zoomIn,
    durationInMilliseconds: 200,
  )
  BusArrivalsScreen busArrivalsScreenRoute;
  MainAboutScreen aboutScreenRoute;
}
