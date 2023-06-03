import 'package:flutter/material.dart';

import '../../../../palette.dart';

class BusArrivalHeader extends StatelessWidget {
  const BusArrivalHeader({
    super.key,
    required this.busStopCode,
    required this.description,
    required this.roadName,
    this.distanceInMeters,
  });

  final String? busStopCode;
  final String? description;
  final String? roadName;
  final int? distanceInMeters;

  @override
  Widget build(BuildContext context) {
    var subTitle = '$busStopCode | $roadName';
    if (distanceInMeters != null) {
      subTitle = '$subTitle | $distanceInMeters m';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description ?? '',
          style: const TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          subTitle,
          style: const TextStyle(
            color: kPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
