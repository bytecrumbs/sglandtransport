import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/utils/platform_brightness.dart';
import 'package:flare_flutter/flare_actor.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Platform.isDarkMode(context);
    final darkModeSuffix = isDarkMode ? '-dark' : '';

    return Container(
      decoration:
          BoxDecoration(color: isDarkMode ? Color(0xFF212121) : Colors.white),
      child: FlareActor(
        'images/bus.flr',
        alignment: Alignment.center,
        fit: BoxFit.fitHeight,
        animation: 'Bus' + darkModeSuffix,
      ),
    );
  }
}
