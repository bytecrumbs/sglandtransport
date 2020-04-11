import 'package:flutter/material.dart';

class BicycleParking extends StatelessWidget {
  static const String id = 'bicycle_parking_screen';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.directions_bike,
            size: 70,
          ),
          const Text('Coming soon!'),
        ],
      ),
    );
  }
}
