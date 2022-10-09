import 'package:flutter/material.dart';

import 'bus_arrival_time.dart';

class BusArrivalSequence extends StatelessWidget {
  const BusArrivalSequence({
    super.key,
    required this.inService,
    required this.nextBusEstimatedArrival,
    required this.nextBusLoadColor,
    required this.nextBus2EstimatedArrival,
    required this.nextBus2LoadColor,
    required this.nextBus3EstimatedArrival,
    required this.nextBus3LoadColor,
  });

  final bool inService;
  final String nextBusEstimatedArrival;
  final Color nextBusLoadColor;
  final String nextBus2EstimatedArrival;
  final Color nextBus2LoadColor;
  final String nextBus3EstimatedArrival;
  final Color nextBus3LoadColor;

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
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: inService
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BusArrivalTime(
                  estimatedArrival: nextBusEstimatedArrival,
                  loadColor: nextBusLoadColor,
                ),
                const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                BusArrivalTime(
                  estimatedArrival: nextBus2EstimatedArrival,
                  loadColor: nextBus2LoadColor,
                ),
                const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                BusArrivalTime(
                  estimatedArrival: nextBus3EstimatedArrival,
                  loadColor: nextBus3LoadColor,
                ),
              ],
            )
          : const Text('Not In Operation'),
    );
  }
}
