// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app/bus/bus_arrival_view.dart';
import '../app/bus/bus_stop_view.dart';

class Routes {
  static const String busStopView = '/';
  static const String busArrivalView = '/bus-arrival-view';
  static const all = <String>{
    busStopView,
    busArrivalView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.busStopView, page: BusStopView),
    RouteDef(Routes.busArrivalView, page: BusArrivalView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    BusStopView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const BusStopView(),
        settings: data,
      );
    },
    BusArrivalView: (data) {
      final args = data.getArgs<BusArrivalViewArguments>(
        orElse: () => BusArrivalViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => BusArrivalView(
          key: args.key,
          busStopCode: args.busStopCode,
          description: args.description,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// BusArrivalView arguments holder class
class BusArrivalViewArguments {
  final Key? key;
  final String busStopCode;
  final String description;
  BusArrivalViewArguments({this.key, this.busStopCode, this.description});
}
