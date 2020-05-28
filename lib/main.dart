import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedantic/pedantic.dart';
import 'package:http/io_client.dart' as http;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lta_datamall_flutter/db/database_provider.dart';
import 'package:lta_datamall_flutter/main_app.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/widgets/loader.dart';
import 'package:lta_datamall_flutter/widgets/splash.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned(() {
    unawaited(DatabaseProvider.db.database);
    runApp(Splash(nextAction: MyApp()));
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  Future<List<BusStopModel>> _initAllBusStops() async {
    return await fetchBusStopList(http.IOClient());
  }

  Future<List<List<BusStopModel>>> _initApp(BuildContext context) async {
    // initialize DB
    return Future.wait([
      _initAllBusStops(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    return FutureBuilder<List<List<BusStopModel>>>(
      future: _initApp(context),
      builder: (BuildContext context,
          AsyncSnapshot<List<List<BusStopModel>>> snapshot) {
        if (snapshot.hasData) {
          return MainApp(
            busStopModelList: snapshot.data[0],
          );
        } else if (snapshot.hasError) {
          Text(snapshot.error.toString());
        }
        return Loader();
      },
    );
  }
}
