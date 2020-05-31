import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/utils/platform_brightness.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

class Splash extends StatelessWidget {
  Splash({@required this.nextAction});

  final Widget nextAction;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Platform.isDarkMode(context);

    return Container(
      decoration:
          BoxDecoration(color: isDarkMode ? Color(0xFF212121) : Colors.white),
      child: SplashScreen.navigate(
        name: 'images/bus.flr',
        startAnimation: isDarkMode ? 'Bus-intro-dark' : 'Bus-intro',
        loopAnimation: isDarkMode ? 'Bus-dark' : 'Bus',
        next: (context) => nextAction,
        until: () => Future.delayed(Duration(milliseconds: 1300)),
      ),
    );
  }
}
