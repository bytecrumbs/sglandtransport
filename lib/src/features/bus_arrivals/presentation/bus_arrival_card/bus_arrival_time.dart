import 'package:flutter/material.dart';

import '../../../../palette.dart';

class BusArrivalTime extends StatelessWidget {
  const BusArrivalTime({
    super.key,
    required this.estimatedArrival,
    required this.busLoad,
  });

  final String estimatedArrival;
  final String busLoad;

  @override
  Widget build(BuildContext context) {
    return estimatedArrival != 'n/a'
        ? DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kBusLoadColors[busLoad] ?? const Color(0x26009B60),
                  width: 6, // Underline thickness
                ),
              ),
            ),
            child: Text(
              estimatedArrival,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        : Text(
            'n/a',
            style: Theme.of(context).textTheme.titleLarge,
          );
  }
}
