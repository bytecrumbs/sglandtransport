import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'bus_favourites_view.dart';
import 'bus_nearby_view.dart';
import 'bus_search_view.dart';
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
      ),
      viewModelBuilder: () => BusViewModel(),
    );
  }
}
