import 'package:flutter/material.dart';

class FavoriteBusStops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Your Favorite Bus Stops',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
