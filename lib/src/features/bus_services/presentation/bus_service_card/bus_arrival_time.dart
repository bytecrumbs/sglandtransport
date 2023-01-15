import 'package:flutter/material.dart';

class BusArrivalTime extends StatelessWidget {
  const BusArrivalTime({
    super.key,
    required this.estimatedArrival,
    required this.loadColor,
  });

  final String estimatedArrival;
  final Color loadColor;

  @override
  Widget build(BuildContext context) {
    return estimatedArrival != 'n/a'
        ? Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: loadColor,
                      width: 6, // Underline thickness
                    ),
                  ),
                ),
                child: Text(
                  estimatedArrival,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          )
        : Text(
            'n/a',
            style: Theme.of(context).textTheme.headline6,
          );
  }
}
