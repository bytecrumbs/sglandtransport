import 'package:auto_route/auto_route_annotations.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_arrival/bus_arrival_view.dart';
import 'package:lta_datamall_flutter/ui/views/bus/bus_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  BusView busViewRoute;
  BusArrivalView busArrivalView;
}
