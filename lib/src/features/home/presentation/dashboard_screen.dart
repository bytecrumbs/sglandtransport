import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../palette.dart';
import '../../bus_arrivals/presentation/favorites/bus_arrival_list_favorites.dart';
import '../../bus_stops/domain/bus_stop_value_model.dart';
import '../../bus_stops/presentation/bus_stop_list_nearby.dart';
import '../../search/application/custom_search_delegate.dart';
import 'dashboard_screen_controller.dart';
import 'drawer.dart';
import 'main_bottom_app_bar.dart';

/// Defines whether the flare animation should loop or be idle. It is done like
/// this (rather than using a useState hook), so that for the integration tests,
/// this value can easily be overriden. To ensure the animation is not looping,
/// specify the value 'Idle'.
final flareAnimationProvider = Provider((ref) => 'Loop');

final busStopValueModelProvider =
    Provider<BusStopValueModel>((_) => throw UnimplementedError());

final isExpandedStateProvider = StateProvider<bool>((ref) => true);

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  static const routeName = '/';

  Widget _getViewForIndex(int? index) {
    switch (index) {
      case 0:
        return const BusStopListNearby();
      case 1:
        return const BusArrivalListFavorites();
      default:
        return const BusStopListNearby();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(dashboardScreenControllerProvider);
    final activeIndexNotifier =
        ref.watch(dashboardScreenControllerProvider.notifier);

    final flareAnimation = ref.watch(flareAnimationProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final sliverAnimationHeight = screenHeight * 0.32;

    final isExpandedState = ref.watch(isExpandedStateProvider);
    final isExpanded = ref.watch(isExpandedStateProvider.notifier);

    final appBarForegroundColor = isExpandedState
        ? kPrimaryColor
        : Theme.of(context).appBarTheme.foregroundColor;

    return Scaffold(
      drawer: const AppDrawer(),
      body: activeIndex.whenOrNull(
        data: (section) => NotificationListener<ScrollNotification>(
          onNotification: (scrollState) {
            isExpanded.state =
                scrollState.metrics.pixels < sliverAnimationHeight / 1.5;
            return true;
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                foregroundColor: appBarForegroundColor,
                elevation: 0,
                title: const Text('SG Land Transport'),
                pinned: true,
                expandedHeight: sliverAnimationHeight,
                actions: <Widget>[
                  IconButton(
                    key: const ValueKey('searchIconButton'),
                    icon: const Icon(Icons.search, size: 27),
                    onPressed: () {
                      showSearch<dynamic>(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: FlareActor.asset(
                    AssetFlare(bundle: rootBundle, name: 'images/city.flr'),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    animation: flareAnimation,
                  ),
                ),
              ),
              _getViewForIndex(section),
            ],
          ),
        ),
      ),
      bottomNavigationBar: activeIndex.whenOrNull(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        data: (section) => MainBottomAppBar(
          activeIndex: section,
          onTap: (clickedItem) async {
            await activeIndexNotifier.onTap(clickedItem: clickedItem);
          },
        ),
      ),
    );
  }
}
