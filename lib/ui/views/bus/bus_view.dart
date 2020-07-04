import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache_builder.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        drawer: AppDrawerView(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            final asset =
                AssetFlare(bundle: rootBundle, name: 'images/city.flr');
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Buses',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Container(
                    child: FlareCacheBuilder(
                      [asset],
                      builder: (BuildContext context, bool isWarm) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 320,
                          child: FlareActor.asset(
                            asset,
                            alignment: Alignment.center,
                            fit: BoxFit.fitHeight,
                            animation: 'Loop',
                          ),
                        );
                      },
                    ),
                  ),
                ),
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
