import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/palette.dart';
import 'features/bus/bus_stop_page_view.dart';
import 'features/bus/dashboard_page_view.dart';
import 'shared/services/rate_app_service.dart';

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
              case DashboardPageView.routeName:
                return const DashboardPageView();
              case BusStopPageView.routeName:
                final args = routeSettings.arguments! as Map<String, String>;
                return BusStopPageView(
                  busStopCode: args['busStopCode']!,
                  description: args['description']!,
                );
              default:
                return const DashboardPageView();
            }
          },
        );
      },
    );
  }
}
