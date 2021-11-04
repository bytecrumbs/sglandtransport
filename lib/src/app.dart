import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rate_my_app/rate_my_app.dart';

import 'bus/bus_stop_list_page_view.dart';
import 'bus/bus_stop_page_view.dart';
import 'shared/common_providers.dart';
import 'shared/palette.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

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
        navigatorObservers: [
          FirebaseAnalyticsObserver(
            analytics: ref.read(analyticsProvider),
          ),
        ],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (context) {
              switch (routeSettings.name) {
                case BusStopListPageView.routeName:
                  return const BusStopListPageView();
                case BusStopPageView.routeName:
                  final args = routeSettings.arguments! as Map<String, String>;
                  return BusStopPageView(
                    busStopCode: args['busStopCode']!,
                    description: args['description']!,
                  );
                default:
                  return const BusStopListPageView();
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

        logger.d('Are all conditions met? '
            '${rateMyApp.shouldOpenDialog ? "Yes" : "No"}');

        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showRateDialog(context,
              title: 'Rate SG Land Transport',
              message:
                  'If you like SG Land Transport, please take a little bit of '
                  'your time to review it!\nIt really helps us and it '
                  "shouldn't take you more than a minute.\nThank you!");
        }
      },
    );
  }
}
