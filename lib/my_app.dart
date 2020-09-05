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
        primaryColorDark: Color(0xFF25304D),
        primaryColor: Color(0xFF969CAE),
        accentColor: Color(0xFFEF3340),
        scaffoldBackgroundColor: Color(0xFFE2EFF5),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Color(0xFF25304D),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          headline2: TextStyle(
            color: Color(0xFF8C8C91),
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
