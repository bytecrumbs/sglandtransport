import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:lta_datamall_flutter/providers/settings_provider.dart';
import 'package:lta_datamall_flutter/screens/bicycle/main_bicycle_screen.dart';
import 'package:lta_datamall_flutter/screens/bus/main_bus_screen.dart';
import 'package:lta_datamall_flutter/screens/settings/main_settings_screen.dart';
import 'package:provider/provider.dart';

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

    return ChangeNotifierProvider<SettingsProvider>(
      create: (_) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (BuildContext context, SettingsProvider settings, _) {
          return MaterialApp(
            title: 'LTA Datamall App',
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              brightness:
                  settings.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            initialRoute: MainBusScreen.id,
            routes: <String, WidgetBuilder>{
              MainBusScreen.id: (BuildContext context) => MainBusScreen(),
              MainBicycleScreen.id: (BuildContext context) =>
                  MainBicycleScreen(),
              MainSettingsScreen.id: (BuildContext context) =>
                  MainSettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
