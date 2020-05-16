import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/services/observer_service_provider.dart';
import 'package:lta_datamall_flutter/screens/bus/favorites_bus_section.dart';
import 'package:lta_datamall_flutter/screens/bus/nearby_bus_section.dart';
import 'package:lta_datamall_flutter/screens/bus/search_bus_section.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class MainBusScreen extends StatefulWidget {
  @override
  _MainBusScreenState createState() => _MainBusScreenState();
}

class _MainBusScreenState extends State<MainBusScreen> {
  _MainBusScreenState();

  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    NearbyBusStops(),
    FavoriteBusStops(),
    SearchBusStops()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buses'),
      ),
      drawer: AppDrawer(),
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (int newValue) {
          setState(() {
            pageIndex = newValue;
            _sendCurrentTabToAnalytics(pageList[pageIndex].toString());
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_searching),
            title: const Text(
              'Nearby',
              key: ValueKey<String>('NearbyScreen'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: const Text('Favorites',
                key: ValueKey<String>('favoriteScreen')),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: const Text('Search', key: ValueKey<String>('searchScreen')),
          ),
        ],
      ),
    );
  }

  void _sendCurrentTabToAnalytics(String screenName) {
    context
        .read<ObserverServiceProvider>()
        .getAnalyticsObserver()
        .analytics
        .setCurrentScreen(
          screenName: screenName,
        );
  }
}
