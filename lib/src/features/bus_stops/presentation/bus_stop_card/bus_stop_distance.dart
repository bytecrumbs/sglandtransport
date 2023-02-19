import 'package:flutter/material.dart';

class BusStopDistance extends StatelessWidget {
  const BusStopDistance({
    super.key,
    this.distanceInMeters,
  });

  final int? distanceInMeters;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (distanceInMeters != null) Text('$distanceInMeters m'),
        const SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.arrow_right,
        ),
      ],
    );
  }
}
