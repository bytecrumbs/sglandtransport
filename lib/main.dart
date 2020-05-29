import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app.dart';
import 'package:pedantic/pedantic.dart';
import 'package:http/io_client.dart' as http;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lta_datamall_flutter/db/database_provider.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/widgets/loader.dart';
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
    runApp(Splash(nextAction: MyApp()));
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<List<BusStopModel>> _busStopList =
      fetchBusStopList(http.IOClient());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BusStopModel>>(
      future: _busStopList,
      builder:
          (BuildContext context, AsyncSnapshot<List<BusStopModel>> snapshot) {
        if (snapshot.hasData) {
          return App(busStopList: snapshot.data);
        } else if (snapshot.hasError) {
          Text(snapshot.error.toString());
        }
        return Loader();
      },
    );
  }
}
