import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bicycle_parking.dart';
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
            initialRoute: MainApp.id,
            routes: <String, WidgetBuilder>{
              MainApp.id: (BuildContext context) => MainApp(),
              Settings.id: (BuildContext context) => Settings(),
              BusArrivals.id: (BuildContext context) => BusArrivals(),
            },
          );
        },
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  static const String id = 'main_app_screen';

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    BusStops(),
    BicycleParking(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LTA Datamall'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Settings.id);
            },
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pageList[pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (int newValue) {
          setState(() {
            pageIndex = newValue;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            title: const Text('Bus timing'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bike),
            title: const Text('Bicycle Parking'),
          ),
        ],
      ),
    );
  }
}
