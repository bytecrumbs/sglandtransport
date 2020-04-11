import 'package:flutter/material.dart';

class BusArrivalHeader extends StatelessWidget {
  const BusArrivalHeader({@required this.headerText});

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      child: Text(
        headerText,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }
}
