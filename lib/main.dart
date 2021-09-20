import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/arrival/bus_arrival_controller.dart';
import 'src/arrival/bus_arrival_service.dart';

void main() {
  final busArrivalController = BusArrivalController(BusArrivalService());

  runApp(
    MyApp(
      busArrivalController: busArrivalController,
    ),
  );
}
