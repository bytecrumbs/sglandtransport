import 'package:auto_route/auto_route_annotations.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_arrival/bus_arrival_view.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_view.dart';
import 'package:lta_datamall_flutter/ui/views/iap/purchase_view.dart';
import 'package:lta_datamall_flutter/ui/views/iap/purchase_view1.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: BusView, initial: true),
  MaterialRoute(page: BusArrivalView),
  MaterialRoute(page: MarketScreen),
  MaterialRoute(page: PurchaseView),
])
class $Router {}
