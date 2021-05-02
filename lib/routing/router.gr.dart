// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/annotations.dart' as _i3;
import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../app/bus/bus_arrival_view.dart' as _i5;
import '../app/bus/bus_stop_view.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    BusStopViewRoute.name: (routeData) {
      return _i1.MaterialPageX<_i3.AutoRoute<dynamic>>(
          routeData: routeData, child: const _i4.BusStopView());
    },
    BusArrivalViewRoute.name: (routeData) {
      final args = routeData.argsAs<BusArrivalViewRouteArgs>();
      return _i1.MaterialPageX<_i3.AutoRoute<dynamic>>(
          routeData: routeData,
          child: _i5.BusArrivalView(
              key: args.key,
              busStopCode: args.busStopCode,
              description: args.description));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(BusStopViewRoute.name, path: '/'),
        _i1.RouteConfig(BusArrivalViewRoute.name, path: '/bus-arrival-view')
      ];
}

class BusStopViewRoute extends _i1.PageRouteInfo {
  const BusStopViewRoute() : super(name, path: '/');

  static const String name = 'BusStopViewRoute';
}

class BusArrivalViewRoute extends _i1.PageRouteInfo<BusArrivalViewRouteArgs> {
  BusArrivalViewRoute(
      {_i2.Key? key, required String busStopCode, required String description})
      : super(name,
            path: '/bus-arrival-view',
            args: BusArrivalViewRouteArgs(
                key: key, busStopCode: busStopCode, description: description));

  static const String name = 'BusArrivalViewRoute';
}

class BusArrivalViewRouteArgs {
  const BusArrivalViewRouteArgs(
      {this.key, required this.busStopCode, required this.description});

  final _i2.Key? key;

  final String busStopCode;

  final String description;
}
