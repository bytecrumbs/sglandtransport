import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../bus_stops/presentation/bus_stop_card/bus_stop_card_with_fetch.dart';
import 'bus_arrival_list.dart';
import 'bus_load_legend.dart';

final timerProvider = StreamProvider<int>((ref) {
  const initialCountdown = 10;
  return Stream<int>.periodic(
    const Duration(seconds: 1),
    (count) => initialCountdown - count,
  ).takeWhile((value) => value >= 0);
});

class BusArrivalsListScreen extends ConsumerWidget {
  const BusArrivalsListScreen({
    super.key,
    required this.busStopCode,
  });

  final String busStopCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(timerProvider).value ?? 10;
    if (timer == 0) {
      // Dispose of the timerProvider when it reaches 0
      ref.invalidate(timerProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Arrivals'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          BusStopCardWithFetch(busStopCode: busStopCode),
          const BusLoadLegend(),
          const SizedBox(
            height: 10,
          ),
          Text('Refresh in: $timer'),
          const SizedBox(
            height: 10,
          ),
          BusArrivalList(busStopCode: busStopCode),
        ],
      ),
    );
  }
}
