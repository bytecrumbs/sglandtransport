import 'package:flutter/material.dart';

import '../../../bus_stops/presentation/bus_stop_card/bus_stop_card_with_fetch.dart';
import 'bus_arrival_list.dart';
import 'bus_load_legend.dart';

class BusArrivalsListScreen extends StatelessWidget {
  const BusArrivalsListScreen({
    super.key,
    required this.busStopCode,
  });

  final String busStopCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Arrivals'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            BusStopCardWithFetch(busStopCode: busStopCode),
            const BusLoadLegend(),
            BusArrivalList(busStopCode: busStopCode),
          ],
        ),
      ),
    );
  }
}
