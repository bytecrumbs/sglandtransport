import 'package:auto_route/auto_route_annotations.dart';

import '../app/bus/bus_stop_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: BusStopView, initial: true),
])
class $Router {}
