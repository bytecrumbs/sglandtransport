import 'package:flutter/material.dart';

import '../../../../constants/palette.dart';

class BusServiceHeader extends StatelessWidget {
  const BusServiceHeader({
    super.key,
    required this.busStopCode,
    required this.description,
    required this.roadName,
  });

  final String? busStopCode;
  final String? description;
  final String? roadName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
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
            '$busStopCode | $roadName',
            style: const TextStyle(
              color: kPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
