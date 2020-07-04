import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/ui/views/app_drawer/app_drawer_view.dart';
import 'package:stacked/stacked.dart';

import 'bus_favourites/bus_favourites_view.dart';
import 'bus_nearby/bus_nearby_view.dart';
import 'bus_search/bus_search_view.dart';
import 'bus_viewmodel.dart';

class BusView extends StatelessWidget {
  final List<Widget> _pageList = <Widget>[
    BusNearbyView(),
    BusFavouritesView(),
    BusSearchView(),
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color.fromRGBO(212, 238, 249, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 50, 0.25),
          elevation: 0,
          title: const Text(
            'Buses',
          ),
        ),
        drawer: AppDrawerView(),
        body: _pageList[model.currentIndex],
        bottomNavigationBar: ConvexAppBar(
          key: Key('BottomBar'),
          color: Colors.grey,
          activeColor: Theme.of(context).accentColor,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          top: -25.0,
          style: TabStyle.react,
          initialActiveIndex: model.currentIndex,
          onTap: model.onItemTapped,
          items: model.tabItems,
        ),
      ),
      viewModelBuilder: () => BusViewModel(),
    );
  }
}