// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/iap/purchase_view1.dart';

import '../ui/views/bus/bus_arrival/bus_arrival_view.dart';
import '../ui/views/bus/bus_view.dart';
import '../ui/views/iap/purchase_view.dart';

class Routes {
  static const String busView = '/';
  static const String busArrivalView = '/bus-arrival-view';
  static const String marketScreen = '/market-screen';
  static const String purchaseView = '/purchase-view';

  static const all = <String>{
    busView,
    busArrivalView,
    marketScreen,
    purchaseView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.busView, page: BusView),
    RouteDef(Routes.busArrivalView, page: BusArrivalView),
    RouteDef(Routes.marketScreen, page: MarketScreen),
    RouteDef(Routes.purchaseView, page: PurchaseView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    BusView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => BusView(),
        settings: data,
      );
    },
    BusArrivalView: (data) {
      final args = data.getArgs<BusArrivalViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => BusArrivalView(
          busStopCode: args.busStopCode,
          description: args.description,
        ),
        settings: data,
      );
    },
    MarketScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => MarketScreen(),
        settings: data,
      );
    },
    PurchaseView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PurchaseView(),
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
  final String busStopCode;
  final String description;
  BusArrivalViewArguments(
      {@required this.busStopCode, @required this.description});
}
