import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bus_stop/bus_stop_list_page_view.dart';
import 'bus_stop/bus_stop_page_view.dart';
import 'shared/common_providers.dart';
import 'shared/palette.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
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
    );
  }
}
