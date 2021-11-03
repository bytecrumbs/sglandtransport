import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../search/custom_search_delegate.dart';
import '../shared/constants.dart';
import '../shared/palette.dart';
import '../shared/services/local_storage_service.dart';
import 'bus_repository.dart';
import 'bus_stop_list_page_view_model.dart';
import 'widgets/bus_stop_list_favorites_view.dart';
import 'widgets/bus_stop_list_nearby_view.dart';

/// Defines whether the flare animation should loop or be idle. It is done like
/// this (rather than using a useState hook), so that for the integration tests,
/// this value can easily be overriden
final flareAnimationProvider = Provider((ref) => 'Loop');

final filterProvider = StateProvider((ref) {
  final vm = ref.watch(busStopListPageViewModelProvider);
  return vm.bottomNavBarFilter();
});

final busStopValueModelProvider =
    Provider<BusStopValueModel>((_) => throw UnimplementedError());

class BusStopListPageView extends ConsumerWidget {
  const BusStopListPageView({Key? key}) : super(key: key);

  static const routeName = '/';

  Widget _getViewForIndex(int? index) {
    switch (index) {
      case 0:
        return const BusStopListNearbyView();
      case 1:
        return const BusStopListFavoritesView();
      default:
        return const BusStopListNearbyView();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);
    final localStorage = ref.watch(localStorageServiceProvider);
    final flareAnimation = ref.watch(flareAnimationProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final sliverAnimationHeight = screenHeight * 0.32;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            title: const Text('Bus Stops'),
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
          _getViewForIndex(filter.state)
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem<IconData>(
            icon: Icons.location_searching,
            title: 'Nearby',
          ),
          TabItem<IconData>(
            icon: Icons.favorite,
            title: 'Favorites',
          )
        ],
        initialActiveIndex: filter.state,
        onTap: (clickedItem) async {
          await localStorage.setInt(bottomBarIndexKey, clickedItem);
          filter.state = clickedItem;
        },
        backgroundColor: Theme.of(context).bottomAppBarColor,
        color: kPrimaryColor,
        activeColor: kAccentColor,
        top: -25,
        style: TabStyle.react,
      ),
    );
  }
}
