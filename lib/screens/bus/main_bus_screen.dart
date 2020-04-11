import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/favorites_bus_section.dart';
import 'package:lta_datamall_flutter/screens/bus/nearby_bus_section.dart';
import 'package:lta_datamall_flutter/screens/bus/search_bus_section.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';

class MainBusScreen extends StatefulWidget {
  static const String id = 'main_bus_screen';

  @override
  _MainBusScreenState createState() => _MainBusScreenState();
}

class _MainBusScreenState extends State<MainBusScreen> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    NearbyBusStops(),
    FavoriteBusStops(),
    SearchBusStops(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buses'),
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
            icon: Icon(Icons.location_searching),
            title: const Text('Nearby'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: const Text('Favorites'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
