import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/app/router.gr.dart';
import 'package:lta_datamall_flutter/environment_config.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flare_flutter/flare_cache.dart';

Future<void> warmupFlare() async {
  await cachedActor(AssetFlare(bundle: rootBundle, name: 'images/city.flr'));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlareCache.doesPrune = false;

  Level logLevel;
  if (foundation.kReleaseMode || EnvironmentConfig.is_flutter_drive_run) {
    logLevel = Level.WARNING;
  } else {
    logLevel = Level.ALL;
  }

  Logger.root.level = logLevel;
  Logger.root.onRecord.listen((record) {
    print(
        '[${record.loggerName}]: ${record.level.name}: ${record.time}: ${record.message}');
  });

  Crashlytics.instance.enableInDevMode = true;
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned(() {
    WidgetsFlutterBinding.ensureInitialized();
    setupLocator();
    // initiate the DB
    // locator<DatabaseService>().database;
    locator<BusService>().addBusRoutesToDb();
    warmupFlare().then((_) {
      runApp(MyApp());
    });
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'SG Land Transport',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColorDark: Color.fromRGBO(37, 48, 77, 1),
        primaryColor: Color.fromRGBO(150, 156, 174, 1),
        accentColor: Color.fromRGBO(239, 51, 64, 1),
        scaffoldBackgroundColor: Color.fromRGBO(226, 239, 245, 1),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Color.fromRGBO(37, 48, 77, 1),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          headline2: TextStyle(
            color: Color.fromRGBO(140, 140, 145, 1),
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      initialRoute: Routes.busViewRoute,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      navigatorObservers: [
        locator<FirebaseAnalyticsService>().analyticsObserver,
      ],
    );
  }
}
