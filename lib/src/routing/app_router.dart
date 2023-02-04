import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:go_router/go_router.dart';

import '../features/bus_services/presentation/bus_stop/bus_services_list_screen.dart';
import '../features/home/presentation/dashboard_screen.dart';

enum AppRoute {
  home,
  busServices,
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
          path: 'busServices/:busStopCode',
          name: AppRoute.busServices.name,
          builder: (context, state) {
            final busStopCode = state.params['busStopCode']!;
            return BusServicesListScreen(
              busStopCode: busStopCode,
            );
          },
        ),
      ],
    ),
  ],
);
