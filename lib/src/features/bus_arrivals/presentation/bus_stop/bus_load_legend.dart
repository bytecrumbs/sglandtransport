import 'package:flutter/material.dart';

import '../../../../constants/palette.dart';

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
        children: const [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kLoadSeatsAvailable,
                  width: 6, // Underline thickness
                ),
              ),
            ),
            child: Text('Seats Avail.'),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kLoadStandingAvailable,
                  width: 6, // Underline thickness
                ),
              ),
            ),
            child: Text('Standing Avail.'),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kLoadLimitedStanding,
                  width: 6, // Underline thickness
                ),
              ),
            ),
            child: Text('Limited Standing'),
          ),
        ],
      ),
    );
  }
}
