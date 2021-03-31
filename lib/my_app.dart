import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pedantic/pedantic.dart';

import 'my_app_initializer.dart';
import 'routing/router.gr.dart';

/// Initializes things that need to be done prior to app start
final appInitFutureProvider = FutureProvider<void>((ref) async {
  final initializer = ref.read(myAppInitializerProvider);

  await initializer.initFirebase();

  await initializer.initLayout();

  // no need to await here, as this can run in the background
  unawaited(initializer.initDatabaseLoad());
});

final _appRouter = AppRouter();

/// The main class, which will first initiate firebase and other things that
/// need to be done on start up.
class MyApp extends HookWidget {
  /// Default constructor
  const MyApp({Key? key}) : super(key: key);

  /// The Firebase analytics reference
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  /// The observer used to log navigation events
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    final appInit = useProvider(appInitFutureProvider);
    return appInit.when(
      data: (appInit) => MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter
            .delegate(navigatorObservers: <NavigatorObserver>[observer]),
        title: 'GitLab Mobile',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColorDark: const Color(0xFF25304D),
          primaryColor: const Color(0xFF969CAE),
          accentColor: const Color(0xFFEF3340),
          scaffoldBackgroundColor: const Color(0xFFE2EFF5),
          textTheme: const TextTheme(
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
      ),
      loading: () => const MaterialApp(
        home: Scaffold(),
      ),
      error: (err, stack) => const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Something went wrong')),
        ),
      ),
    );
  }
}
