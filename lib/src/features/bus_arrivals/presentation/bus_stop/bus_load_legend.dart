import 'package:flutter/material.dart';

import '../../../../palette.dart';

class BusLoadLegend extends StatelessWidget {
  const BusLoadLegend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kBusLoadColors['SEA']!,
                  width: 6, // Underline thickness
                ),
              ),
            ),
            child: const Text('Seats Avail.'),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kBusLoadColors['SDA']!,
                  width: 6, // Underline thickness
                ),
              ),
            ),
            child: const Text('Standing Avail.'),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kBusLoadColors['LDS']!,
                  width: 6, // Underline thickness
                ),
              ),
            ),
            child: const Text('Limited Standing'),
          ),
        ],
      ),
    );
  }
}
