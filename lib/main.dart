import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart' as http;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lta_datamall_flutter/services/api.dart';
import 'package:lta_datamall_flutter/apprater.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/models/user_location.dart';
import 'package:lta_datamall_flutter/providers/bus/favorite_bus_stops_provider.dart';
import 'package:lta_datamall_flutter/providers/bus/nearby_bus_stops_provider.dart';
import 'package:lta_datamall_flutter/providers/bus/search_bus_stops_provider.dart';
import 'package:lta_datamall_flutter/providers/location_provider.dart';
import 'package:lta_datamall_flutter/providers/observer_provider.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:lta_datamall_flutter/widgets/loader.dart';
import 'package:lta_datamall_flutter/widgets/splash.dart';

Future<void> main() async {
  await DotEnv().load('.env');

  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned(() {
    runApp(Splash(nextAction: MyApp()));
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  final AppRater appRater = AppRater();

  Future<List<BusStopModel>> _initAllBusStops() async {
    return await fetchBusStopList(http.IOClient());
  }

  Future<List<List<BusStopModel>>> _initApp(BuildContext context) async {
    appRater.showRateMyApp(context);
    return Future.wait(<Future<List<BusStopModel>>>[
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
          // full bus stop list for nearby screen
          final busStopModelListForNearby = snapshot.data[0];
          // create a deep copy of the bus list for favorites screen
          final busStopModelListForFavorites = List<BusStopModel>.generate(
            busStopModelListForNearby.length,
            (int i) =>
                BusStopModel.fromJson(busStopModelListForNearby[i].toJson()),
          );
          return MainApp(
            busStopModelListForNearby: busStopModelListForNearby,
            busStopModelListForFavorites: busStopModelListForFavorites,
          );
        } else if (snapshot.hasError) {
          // do something on error
        }
        return Loader();
      },
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({
    @required this.busStopModelListForNearby,
    @required this.busStopModelListForFavorites,
  });

  final List<BusStopModel> busStopModelListForNearby;
  final List<BusStopModel> busStopModelListForFavorites;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<ObserverProvider>(
          create: (_) => ObserverProvider(),
        ),
        ChangeNotifierProvider<NearbyBusStopsProvider>(
          create: (_) => NearbyBusStopsProvider(
              allBusStops: busStopModelListForNearby),
        ),
        ChangeNotifierProvider<FavoriteBusStopsProvider>(
          create: (_) => FavoriteBusStopsProvider(
              allBusStops: busStopModelListForFavorites),
        ),
        ChangeNotifierProvider<SearchBusStopsProvider>(
          create: (_) => SearchBusStopsProvider(
              allBusStops: busStopModelListForFavorites),
        ),
        StreamProvider<UserLocation>(
          create: (_) => LocationProvider().locationStream,
        )
      ],
      child: Consumer<ObserverProvider>(
        builder: (
          BuildContext context,
          ObserverProvider observer,
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
            title: 'SG Land Transport',
            darkTheme: ThemeData.dark(),
            theme: ThemeData.light(),
          );
        },
      ),
    );
  }
}
