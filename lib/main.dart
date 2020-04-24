import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:lta_datamall_flutter/services/bus/bus_stops_service_provider.dart';
import 'package:lta_datamall_flutter/services/observer_service_provider.dart';
import 'package:lta_datamall_flutter/services/settings_service_provider.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';
import 'package:lta_datamall_flutter/services/bus/bus_favorites_service_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned(() {
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<SettingsServiceProvider>(
          create: (_) => SettingsServiceProvider(),
        ),
        Provider<ObserverServiceProvider>(
          create: (_) => ObserverServiceProvider(),
        ),
        ChangeNotifierProvider<BusFavoritesServiceProvider>(
          create: (_) => BusFavoritesServiceProvider(),
        ),
        ChangeNotifierProvider<BusStopsServiceProvider>(
          create: (_) => BusStopsServiceProvider(),
        ),
      ],
      child: Consumer2<SettingsServiceProvider, ObserverServiceProvider>(
        builder: (
          BuildContext context,
          SettingsServiceProvider settings,
          ObserverServiceProvider observer,
          _,
        ) {
          return MaterialApp(
            builder: ExtendedNavigator<Router>(
              initialRoute: Routes.mainBusScreenRoute,
              router: Router(),
              observers: <NavigatorObserver>[
                observer.getAnalyticsObserver(),
              ],
            ),
            title: 'LTA Datamall App',
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              brightness:
                  settings.isDarkMode ? Brightness.dark : Brightness.light,
            ),
          );
        },
      ),
    );
  }
}
