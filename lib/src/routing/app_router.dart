import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/bus_arrivals/presentation/bus_stop/bus_arrival_list_screen.dart';
import '../features/bus_services/presentation/bus_service_screen.dart';
import '../features/home/presentation/dashboard_screen.dart';

enum AppRoute {
  home,
  busArrivals,
  busRoutes,
  busDetails,
}

final goRouter = GoRouter(
  initialLocation: '/',
  observers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const DashboardScreen(),
      routes: [
        GoRoute(
          path: 'busArrivals/:busStopCode',
          name: AppRoute.busArrivals.name,
          builder: (context, state) {
            final busStopCode = state.pathParameters['busStopCode']!;
            return BusArrivalsListScreen(
              busStopCode: busStopCode,
            );
          },
        ),
        GoRoute(
          path: 'busDetails/:serviceNo/:busStopCode/:destinationCode',
          name: AppRoute.busDetails.name,
          pageBuilder: (context, state) {
            final busStopCode = state.pathParameters['busStopCode']!;
            final serviceNo = state.pathParameters['serviceNo']!;
            final destinationCode = state.pathParameters['destinationCode']!;
            return MaterialPage<BusServiceScreen>(
              key: state.pageKey,
              fullscreenDialog: true,
              child: BusServiceScreen(
                serviceNo: serviceNo,
                busStopCode: busStopCode,
                destinationCode: destinationCode,
              ),
            );
          },
        ),
      ],
    ),
  ],
);
