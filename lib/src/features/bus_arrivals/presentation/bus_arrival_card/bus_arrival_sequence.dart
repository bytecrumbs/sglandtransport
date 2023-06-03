import 'package:flutter/material.dart';

import 'bus_arrival_time.dart';

class BusArrivalSequence extends StatelessWidget {
  const BusArrivalSequence({
    super.key,
    required this.inService,
    required this.nextBusEstimatedArrival,
    required this.nextBusLoad,
    required this.nextBus2EstimatedArrival,
    required this.nextBus2Load,
    required this.nextBus3EstimatedArrival,
    required this.nextBus3Load,
  });

  final bool inService;
  final String nextBusEstimatedArrival;
  final String nextBusLoad;
  final String nextBus2EstimatedArrival;
  final String nextBus2Load;
  final String nextBus3EstimatedArrival;
  final String nextBus3Load;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: inService
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BusArrivalTime(
                  estimatedArrival: nextBusEstimatedArrival,
                  busLoad: nextBusLoad,
                ),
                const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                BusArrivalTime(
                  estimatedArrival: nextBus2EstimatedArrival,
                  busLoad: nextBus2Load,
                ),
                const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                BusArrivalTime(
                  estimatedArrival: nextBus3EstimatedArrival,
                  busLoad: nextBus3Load,
                ),
              ],
            )
          : const Text('Not In Operation'),
    );
  }
}
