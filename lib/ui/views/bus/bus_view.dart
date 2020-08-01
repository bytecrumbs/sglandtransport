import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/ui/views/app_drawer/app_drawer_view.dart';
import 'package:lta_datamall_flutter/ui/views/shared/sliver_view/sliver_view.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:stacked/stacked.dart';

import 'bus_favourites/bus_favourites_view.dart';
import 'bus_nearby/bus_nearby_view.dart';
import 'bus_viewmodel.dart';

class BusView extends StatelessWidget {
  static final _log = Logger('BusView');

  Widget _getViewForIndex(int index) {
    switch (index) {
      case 0:
        return BusNearbyView();
      case 1:
        return BusFavouritesView();
      default:
        return BusNearbyView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RateMyAppBuilder(
      builder: (context) => ViewModelBuilder<BusViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          drawer: AppDrawerView(),
          body: SliverView(
            title: model.appBarTitle,
            child: _getViewForIndex(model.currentIndex),
          ),
          bottomNavigationBar: ConvexAppBar(
            key: Key('BottomBar'),
            color: Theme.of(context).primaryColorDark,
            activeColor: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            top: -25.0,
            style: TabStyle.react,
            initialActiveIndex: model.currentIndex,
            onTap: model.setIndex,
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
        ),
        viewModelBuilder: () => BusViewModel(),
      ),
      rateMyApp: RateMyApp(
        preferencesPrefix: 'rateMyApp_',
        minDays: 7,
        minLaunches: 10,
        remindDays: 7,
        remindLaunches: 10,
      ),
      onInitialized: (context, rateMyApp) {
        rateMyApp.conditions.forEach((condition) {
          if (condition is DebuggableCondition) {
            _log.info(condition
                .valuesAsString); // We iterate through our list of conditions and we print all debuggable ones.
          }
        });

        _log.info('Are all conditions met ? ' +
            (rateMyApp.shouldOpenDialog ? 'Yes' : 'No'));

        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showRateDialog(context);
        }
      },
    );
  }
}
