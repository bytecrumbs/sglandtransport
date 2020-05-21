import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlareActor(
      'images/bus.flr',
      alignment: Alignment.center,
      fit: BoxFit.fitHeight,
      animation: 'Bus-end',
    );
  }
}
