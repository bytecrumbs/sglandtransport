import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';

import '../features/bus_arrivals/presentation/bus_stop/bus_arrival_list_screen.dart';
import '../features/bus_routes/presentation/bus_route_screen.dart';
import '../features/home/presentation/dashboard_screen.dart';

enum AppRoute {
  home,
  busArrivals,
  busRoutes,
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
            final busStopCode = state.params['busStopCode']!;
            return BusArrivalsListScreen(
              busStopCode: busStopCode,
            );
          },
          routes: [
            GoRoute(
              path: 'busRoutes/:serviceNo/:originalCode/:destinationCode',
              name: AppRoute.busRoutes.name,
              builder: (context, state) {
                final busStopCode = state.params['busStopCode']!;
                final serviceNo = state.params['serviceNo']!;
                final originalCode = state.params['originalCode']!;
                final destinationCode = state.params['destinationCode']!;
                return BusRouteScreen(
                  busStopCode: busStopCode,
                  serviceNo: serviceNo,
                  originalCode: originalCode,
                  destinationCode: destinationCode,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
