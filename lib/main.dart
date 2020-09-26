import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/environment_config.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flare_flutter/flare_cache.dart';

import 'my_app.dart';

Future<void> warmupFlare() async {
  await cachedActor(AssetFlare(bundle: rootBundle, name: 'images/city.flr'));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlareCache.doesPrune = false;

  Level logLevel;
  if (foundation.kReleaseMode || EnvironmentConfig.isFlutterDriveRun) {
    logLevel = Level.WARNING;
  } else {
    logLevel = Level.ALL;
  }

  Logger.root.level = logLevel;
  Logger.root.onRecord.listen((record) {
    print(
        '[${record.loggerName}]: ${record.level.name}: ${record.time}: ${record.message}');
  });

  Crashlytics.instance.enableInDevMode = false;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  locator<BusService>().addBusRoutesToDb();
  warmupFlare().then((_) {
    runApp(MyApp());
  });
}
