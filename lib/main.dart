import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart' as http;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:lta_datamall_flutter/api.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus/favorite_bus_stops_service_provider.dart';
import 'package:lta_datamall_flutter/services/bus/nearby_bus_stops_service_provider.dart';
import 'package:lta_datamall_flutter/services/bus/search_bus_stops_service_provider.dart';
import 'package:lta_datamall_flutter/services/observer_service_provider.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';
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
  Future<List<BusStopModel>> _initAllBusStops() async {
    return await fetchBusStopList(http.IOClient());
  }

  Future<List<List<BusStopModel>>> _initApp() async {
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
      future: _initApp(),
      builder: (BuildContext context,
          AsyncSnapshot<List<List<BusStopModel>>> snapshot) {
        if (snapshot.hasData) {
          // full bus stop list for nearby screen
          final List<BusStopModel> busStopModelListForNearby = snapshot.data[0];
          // create a deep copy of the bus list for favorites screen
          final List<BusStopModel> busStopModelListForFavorites =
              List<BusStopModel>.generate(
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
        return SplashScreen();
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LTA Datamall App',
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text('Initializing data...'),
              SizedBox(height: 10),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
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
        Provider<ObserverServiceProvider>(
          create: (_) => ObserverServiceProvider(),
        ),
        ChangeNotifierProvider<NearbyBusStopsServiceProvider>(
          create: (_) => NearbyBusStopsServiceProvider(
              allBusStops: busStopModelListForNearby),
        ),
        ChangeNotifierProvider<FavoriteBusStopsServiceProvider>(
          create: (_) => FavoriteBusStopsServiceProvider(
              allBusStops: busStopModelListForFavorites),
        ),
        ChangeNotifierProvider<SearchBusStopsServiceProvider>(
          create: (_) => SearchBusStopsServiceProvider(
              allBusStops: busStopModelListForFavorites),
        ),
      ],
      child: Consumer<ObserverServiceProvider>(
        builder: (
          BuildContext context,
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
            theme: ThemeData.light(),
          );
        },
      ),
    );
  }
}
