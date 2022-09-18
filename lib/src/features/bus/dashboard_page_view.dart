import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/local_storage_keys.dart';
import '../../constants/palette.dart';
import '../../features/drawer/drawer_view.dart';
import '../../features/search/custom_search_delegate.dart';
import '../../shared/services/local_storage_service.dart';
import 'bus_repository.dart';
import 'widgets/bus_service_list_favorites_view.dart';
import 'widgets/bus_stop_list_nearby_view.dart';
import 'widgets/main_bottom_app_bar.dart';

/// Defines whether the flare animation should loop or be idle. It is done like
/// this (rather than using a useState hook), so that for the integration tests,
/// this value can easily be overriden. To ensure the animation is not looping,
/// specify the value 'Idle'.
final flareAnimationProvider = Provider((ref) => 'Loop');

final bottomBarIndexProvider = StateProvider((ref) {
  final localStorage = ref.watch(localStorageServiceProvider);
  return localStorage.getInt(bottomBarIndexKey) ?? 0;
});

final busStopValueModelProvider =
    Provider<BusStopValueModel>((_) => throw UnimplementedError());

class DashboardPageView extends HookConsumerWidget {
  const DashboardPageView({super.key});

  static const routeName = '/';

  Widget _getViewForIndex(int? index) {
    switch (index) {
      case 0:
        return const BusStopListNearbyView();
      case 1:
        return const BusServiceListFavoritesView();
      default:
        return const BusStopListNearbyView();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(bottomBarIndexProvider);
    final filterController = ref.watch(bottomBarIndexProvider.notifier);
    final localStorage = ref.watch(localStorageServiceProvider);
    final flareAnimation = ref.watch(flareAnimationProvider);

    final screenHeight = MediaQuery.of(context).size.height;
    final sliverAnimationHeight = screenHeight * 0.32;

    final isExpanded = useState(true);
    final appBarForegroundColor = isExpanded.value
        ? kPrimaryColor
        : Theme.of(context).appBarTheme.foregroundColor;

    return Scaffold(
      drawer: const DrawerView(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollState) {
          isExpanded.value =
              scrollState.metrics.pixels < sliverAnimationHeight / 1.5;
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              foregroundColor: appBarForegroundColor,
              elevation: 0,
              title: const Text('Dashboard'),
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
            _getViewForIndex(filterState)
          ],
        ),
      ),
      bottomNavigationBar: MainBottomAppBar(
        activeIndex: filterState,
        onTap: (clickedItem) async {
          await localStorage.setInt(bottomBarIndexKey, clickedItem);
          filterController.state = clickedItem;
        },
      ),
    );
  }
}
