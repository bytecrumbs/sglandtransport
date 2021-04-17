import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:pedantic/pedantic.dart';

import 'routing/router.gr.dart';
import 'services/api.dart';
import 'services/database_service.dart';

final _appRouter = AppRouter();

/// The main class, which will first initiate firebase and other things that
/// need to be done on start up.
class MyApp extends HookWidget {
  /// Default constructor
  const MyApp({Key? key}) : super(key: key);

  static final _log = Logger('MyApp');

  /// The Firebase analytics reference
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  /// The observer used to log navigation events
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  Future _initDatabaseLoad(
    DatabaseService dbService,
    Api api,
  ) async {
    _log.info('initializing database load');

    final creationDateRecord = await dbService.getCreationDateOfBusRoutes();
    if (creationDateRecord.isNotEmpty) {
      final creationDateMillisecondsSinceEpoch =
          creationDateRecord.first['creationTimeSinceEpoch'] as int;
      final creationDate = DateTime.fromMillisecondsSinceEpoch(
          creationDateMillisecondsSinceEpoch);
      final differenceInDays = DateTime.now().difference(creationDate).inDays;
      if (differenceInDays > 30) {
        _log.info('repopulating the DB, as it has expired');
        await _populateBusRoutesDbfromApi(dbService, api);
      }
    } else {
      _log.info('repopulating the DB, as it has not yet been populated');
      await _populateBusRoutesDbfromApi(dbService, api);
    }
  }

  Future _populateBusRoutesDbfromApi(
    DatabaseService dbService,
    Api api,
  ) async {
    final allBusRoutes = await api.fetchBusRouteList();
    await dbService.deleteBusRoutes();
    await dbService.insertBusRoutes(allBusRoutes);
    await dbService.insertBusRoutesTableCreationDate(
        millisecondsSinceEpoch: DateTime.now().millisecondsSinceEpoch);
  }

  @override
  Widget build(BuildContext context) {
    // populate the bus routes in the background
    unawaited(
      _initDatabaseLoad(
        useProvider(databaseServiceProvider),
        useProvider(apiProvider),
      ),
    );
    return MaterialApp.router(
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
    );
  }
}
