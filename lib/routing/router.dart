import 'package:auto_route/auto_route_annotations.dart';
import '../app/bus/bus_arrival_view.dart';
import '../app/bus/bus_stop_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: BusStopView, initial: true),
  MaterialRoute(page: BusArrivalView),
])

/// The main router class. This is coming from the auto_route package and
/// will generate a router.gr.dart file
class $Router {}
