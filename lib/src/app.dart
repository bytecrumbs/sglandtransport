import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'features/bus/bus_stop_page_view.dart';
import 'features/bus/dashboard_page_view.dart';
import 'shared/common_providers.dart';
import 'shared/palette.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logger = ref.watch(loggerProvider);
    return RateMyAppBuilder(
      builder: (context) => MaterialApp(
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
      ),
      rateMyApp: RateMyApp(
        minDays: 7,
        minLaunches: 10,
        remindDays: 7,
        remindLaunches: 10,
      ),
      onInitialized: (context, rateMyApp) {
        for (final condition in rateMyApp.conditions) {
          if (condition is DebuggableCondition) {
            logger.d(condition.valuesAsString);
          }
        }

        logger.d(
          'Are all conditions met? '
          '${rateMyApp.shouldOpenDialog ? "Yes" : "No"}',
        );

        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showRateDialog(
            context,
            title: 'Rate SG Land Transport',
            message:
                'If you like SG Land Transport, please take a little bit of '
                'your time to review it!\nIt really helps us and it '
                "shouldn't take you more than a minute.\nThank you!",
          );
        }
      },
    );
  }
}
