import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/palette.dart';
import 'features/bus_services/presentation/bus_stop/bus_services_list_screen.dart';
import 'features/home/presentation/dashboard_screen.dart';
import 'features/rate_app/application/rate_app_service.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(rateAppServiceProvider).requestReview();

    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(
        scaffoldBackgroundColor: kMainBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
        ),
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (context) {
            switch (routeSettings.name) {
              case DashboardScreen.routeName:
                return const DashboardScreen();
              case BusServicesListScreen.routeName:
                final args = routeSettings.arguments! as Map<String, String>;
                return BusServicesListScreen(
                  busStopCode: args['busStopCode']!,
                  description: args['description']!,
                );
              default:
                return const DashboardScreen();
            }
          },
        );
      },
    );
  }
}
