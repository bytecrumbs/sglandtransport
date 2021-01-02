import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../../common_widgets/app_drawer_view.dart';
import '../../common_widgets/error_view.dart';
import '../../common_widgets/sliver_view.dart';
import '../../constants.dart';
import '../../services/local_storage_service.dart';
import '../failure.dart';
import 'bus_favorites_view.dart';
import 'bus_nearby_view.dart';

/// Stores the selected index of the bottom bar
final bottomBarIndexFutureProvider = FutureProvider<int>((ref) {
  final localStorage = ref.read(localStorageServiceProvider);
  return localStorage.getInt(Constants.bottomBarIndexKey);
});

/// The main bus view, in which you can switch between nearby and
/// favorite bus stops
class BusStopView extends HookWidget {
  static final _log = Logger('BusStopView');
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
    var bottomBarIndex = useProvider(bottomBarIndexFutureProvider);
    var localStorage = useProvider(localStorageServiceProvider);
    return RateMyAppBuilder(
      builder: (context) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: AppDrawerView(),
        body: SliverView(
            title: 'Buses',
            child: bottomBarIndex.when(
                data: _getViewForIndex,
                loading: () => Container(),
                error: (err, stack) {
                  if (err is Failure) {
                    return ErrorView(message: err.message);
                  }
                  return ErrorView();
                })),
        bottomNavigationBar: bottomBarIndex.when(
          data: (index) => ConvexAppBar(
            key: Key('BottomBar'),
            color: Theme.of(context).primaryColorDark,
            activeColor: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).bottomAppBarColor,
            top: -25.0,
            style: TabStyle.react,
            initialActiveIndex: index,
            onTap: (var i) async {
              await localStorage.setInt(Constants.bottomBarIndexKey, i);
              context.refresh(bottomBarIndexFutureProvider);
            },
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
          loading: () => Container(),
          error: (err, stack) {
            if (err is Failure) {
              return ErrorView(message: err.message);
            }
            return ErrorView();
          },
        ),
      ),
      rateMyApp: RateMyApp(
        preferencesPrefix: 'rateMyApp_',
        minDays: 7,
        minLaunches: 10,
        remindDays: 7,
        remindLaunches: 10,
      ),
      onInitialized: (context, rateMyApp) {
        // rateMyApp.conditions.forEach((condition) {
        for (var condition in rateMyApp.conditions) {
          if (condition is DebuggableCondition) {
            _log.info(condition.valuesAsString);
          }
        }

        _log.info('Are all conditions met? '
            '${rateMyApp.shouldOpenDialog ? "Yes" : "No"}');

        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showRateDialog(context,
              title: 'Rate SG Land Transport',
              message:
                  'If you like SG Land Transport, please take a little bit of '
                  'your time to review it!\nIt really helps us and it '
                  'shouldn\'t take you more than a minute.\nThank you!');
        }
      },
    );
  }
}
