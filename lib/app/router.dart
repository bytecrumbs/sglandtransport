import 'package:auto_route/auto_route_annotations.dart';

import 'bus/bus_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: BusView, initial: true),
])
class $Router {}
