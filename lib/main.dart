import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/overview.dart';
import 'package:lta_datamall_flutter/providers/settings_provider.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals.dart';
import 'package:lta_datamall_flutter/screens/bus_stops.dart';
import 'package:lta_datamall_flutter/screens/settings.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsProvider>(
      create: (_) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (BuildContext context, SettingsProvider settings, _) {
          return MaterialApp(
            title: 'LTA Datamall App',
            darkTheme: ThemeData.dark(),
            theme: ThemeData(
              brightness:
                  settings.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            initialRoute: Overview.id,
            routes: <String, WidgetBuilder>{
              Overview.id: (BuildContext context) => Overview(),
              Settings.id: (BuildContext context) => Settings(),
              BusStops.id: (BuildContext context) => BusStops(),
              BusArrivals.id: (BuildContext context) => BusArrivals(),
            },
          );
        },
      ),
    );
  }
}
