import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lta_datamall_flutter/services/custom_search_delegate.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final _sliverAnimationHeight = screenHeight * 0.33;
    return ViewModelBuilder<BusViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: AppDrawerView(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            final asset =
                AssetFlare(bundle: rootBundle, name: 'images/city.flr');
            return <Widget>[
              SliverAppBar(
                title: Text(model.appBarTitle),
                pinned: true,
                floating: false,
                snap: false,
                expandedHeight: _sliverAnimationHeight,
                backgroundColor: Theme.of(context).primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    height: 320,
                    child: FlareActor.asset(
                      asset,
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      animation: 'Loop',
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
                  ),
                ],
              ),
            ];
          },
          body: _pageList[model.currentIndex],
        ),
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
