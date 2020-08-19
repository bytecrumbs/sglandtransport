import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/app/router.gr.dart';
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';
import 'package:stacked_services/stacked_services.dart';

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
      initialRoute: Routes.busView,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      navigatorObservers: [
        locator<FirebaseAnalyticsService>().analyticsObserver,
      ],
    );
  }
}
