import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart' as http;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lta_datamall_flutter/api.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/services/bus/favorite_bus_stops_service_provider.dart';
import 'package:lta_datamall_flutter/services/bus/nearby_bus_stops_service_provider.dart';
import 'package:lta_datamall_flutter/services/bus/search_bus_stops_service_provider.dart';
import 'package:lta_datamall_flutter/services/observer_service_provider.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:lta_datamall_flutter/widgets/loader.dart';
import 'package:lta_datamall_flutter/widgets/splash.dart';
import 'package:rate_my_app/rate_my_app.dart';

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
  final RateMyApp _rateMyApp = RateMyApp(
    minDays: 3,
    preferencesPrefix: 'rateMySGLandTransportApp_',
    minLaunches: 10,
    remindDays: 5,
    remindLaunches: 10,
  );

  Future<List<BusStopModel>> _initAllBusStops() async {
    return await fetchBusStopList(http.IOClient());
  }

  Future<List<List<BusStopModel>>> _initApp(BuildContext context) async {
    await initRateMyApp(context);
    return Future.wait(<Future<List<BusStopModel>>>[
      _initAllBusStops(),
    ]);
  }

  Future initRateMyApp(BuildContext context) async {
    await _rateMyApp.init().then(
          (_) => {
            if (_rateMyApp.shouldOpenDialog)
              {
                _rateMyApp.showStarRateDialog(
                  context,
                  title: 'Enjoying SG Land Transport?',
                  message: 'Let us know what you think',
                  actionsBuilder: (context, stars) {
                    return [
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () async {
                          (stars == null ? '0' : _rateMyApp.launchStore());
                          await _rateMyApp
                              .callEvent(RateMyAppEventType.rateButtonPressed);
                          Navigator.pop<RateMyAppDialogButton>(
                              context, RateMyAppDialogButton.rate);
                        },
                      )
                    ];
                  },
                  ignoreIOS: false,
                  dialogStyle: DialogStyle(
                    titleAlign: TextAlign.center,
                    messageAlign: TextAlign.center,
                    messagePadding: EdgeInsets.only(bottom: 20),
                  ),
                  starRatingOptions: StarRatingOptions(),
                  onDismissed: () => _rateMyApp.callEvent(
                    RateMyAppEventType.laterButtonPressed,
                  ),
                )
              }
          },
        );
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
