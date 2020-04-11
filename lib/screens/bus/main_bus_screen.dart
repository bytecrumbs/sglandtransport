import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bicycle/bicycle_parking.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stops_screen.dart';
import 'package:lta_datamall_flutter/screens/settings/settings.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';

class MainBusScreen extends StatefulWidget {
  static const String id = 'main_bus_screen';

  @override
  _MainBusScreenState createState() => _MainBusScreenState();
}

class _MainBusScreenState extends State<MainBusScreen> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    BusStops(),
    BicycleParking(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LTA Datamall'),
      ),
      drawer: AppDrawer(),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
