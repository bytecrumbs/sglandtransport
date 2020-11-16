import 'package:auto_route/auto_route_annotations.dart';

import '../app/bus/bus_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: BusView, initial: true),
])
class $Router {}
