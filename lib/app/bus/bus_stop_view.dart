import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/sliver_view.dart';
import 'bus_favorites_view.dart';
import 'bus_nearby_view.dart';

/// Stores the selected index of the bottom bar
final bottomBarIndexStateProvider = StateProvider<int>((ref) => 0);

/// The main bus view, in which you can switch between nearby and
/// favorite bus stops
class BusStopView extends HookWidget {
  Widget _getViewForIndex(int index) {
    switch (index) {
      case 0:
        return BusNearbyView();
      case 1:
        return BusFavoritesView();
      default:
        return BusNearbyView();
    }
  }

  @override
  Widget build(BuildContext context) {
    var bottomBarIndex = useProvider(bottomBarIndexStateProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SliverView(
        title: 'Buses',
        child: _getViewForIndex(bottomBarIndex.state),
      ),
      bottomNavigationBar: ConvexAppBar(
        key: Key('BottomBar'),
        color: Theme.of(context).primaryColorDark,
        activeColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        top: -25.0,
        style: TabStyle.react,
        initialActiveIndex: bottomBarIndex.state,
        onTap: (var i) => bottomBarIndex.state = i,
        items: [
          TabItem(
            icon: Icons.location_searching,
            title: 'Nearby',
          ),
          TabItem(
            icon: Icons.favorite,
            title: 'Favorites',
          )
        ],
      ),
    );
  }
}
