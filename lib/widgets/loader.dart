import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Loader extends StatelessWidget {
  Loader({
    this.size = 100,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(size / 2),
        clipBehavior: Clip.antiAlias,
        child: FlareActor('images/bus.flr',
            alignment: Alignment.center, fit: BoxFit.contain, animation: 'Bus'),
      ),
    );
  }
}
