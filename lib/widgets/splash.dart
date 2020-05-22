import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

class Splash extends StatelessWidget {
  Splash({@required this.nextAction});

  final Widget nextAction;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SplashScreen.navigate(
          name: 'images/bus.flr',
          startAnimation: 'Bus-intro',
          loopAnimation: 'Bus',
          next: (context) => nextAction,
          until: () => Future.delayed(Duration(milliseconds: 1300)),
        ),
      ),
    );
  }
}
