// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i4;

import '../app/bus/bus_arrival_view.dart' as _i3;
import '../app/bus/bus_stop_view.dart' as _i2;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    BusStopViewRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: const _i2.BusStopView());
    },
    BusArrivalViewRoute.name: (entry) {
      var args = entry.routeData.argsAs<BusArrivalViewRouteArgs>(
          orElse: () => BusArrivalViewRouteArgs());
      return _i1.MaterialPageX(
          entry: entry,
          child: _i3.BusArrivalView(
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
  BusArrivalViewRoute({_i4.Key? key, String busStopCode, String description})
      : super(name,
            path: '/bus-arrival-view',
            args: BusArrivalViewRouteArgs(
                key: key, busStopCode: busStopCode, description: description));

  static const String name = 'BusArrivalViewRoute';
}

class BusArrivalViewRouteArgs {
  const BusArrivalViewRouteArgs({this.key, this.busStopCode, this.description});

  final _i4.Key? key;

  final String busStopCode;

  final String description;
}
