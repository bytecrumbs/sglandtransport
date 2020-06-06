import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app.dart';
import 'package:pedantic/pedantic.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lta_datamall_flutter/db/database_provider.dart';
import 'package:lta_datamall_flutter/widgets/splash.dart';

Future<void> main() async {
  await DotEnv().load('.env');

  Level logLevel;
  if (foundation.kReleaseMode) {
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
    unawaited(DatabaseProvider.db.database);
    runApp(MyApp());
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
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: App(),
    );
  }
}
