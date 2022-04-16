import 'package:flutter/material.dart';

import '../../shared/palette.dart';

class BusServiceHeader extends StatelessWidget {
  const BusServiceHeader({
    Key? key,
    required this.busStopCode,
    required this.description,
    required this.roadName,
  }) : super(key: key);

  final String? busStopCode;
  final String? description;
  final String? roadName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          color: kPrimaryColor,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            '$busStopCode - $description - $roadName',
            style: const TextStyle(
              color: kMainBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
