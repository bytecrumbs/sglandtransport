import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/providers/observer_provider.dart';
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
      bottomNavigationBar: ConvexAppBar(
        key: Key('BottomBar'),
        color: Colors.grey,
        activeColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        top: -25.0,
        style: TabStyle.react,
        initialActiveIndex: pageIndex,
        onTap: (int newValue) {
          setState(() {
            pageIndex = newValue;
            _sendCurrentTabToAnalytics(pageList[pageIndex].toString());
          });
        },
        items: [
          TabItem(
            icon: Icons.location_searching,
            title: 'Nearby',
          ),
          TabItem(
            icon: Icons.favorite,
            title: 'Favorites',
          ),
          TabItem(
            icon: Icons.search,
            title: 'Search',
          ),
        ],
      ),
    );
  }

  void _sendCurrentTabToAnalytics(String screenName) {
    context
        .read<ObserverProvider>()
        .getAnalyticsObserver()
        .analytics
        .setCurrentScreen(
          screenName: screenName,
        );
  }
}
