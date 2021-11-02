import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search/custom_search_delegate.dart';
import '../shared/constants.dart';
import '../shared/services/local_storage_service.dart';
import 'widgets/bus_stop_list_favorites.dart';
import 'widgets/bus_stop_list_nearby.dart';

final filterProvider = StateProvider((ref) {
  final localStorage = ref.watch(localStorageServiceProvider);
  return localStorage.getInt(bottomBarIndexKey);
});

class BusStopListPage extends ConsumerWidget {
  const BusStopListPage({Key? key}) : super(key: key);

  static const routeName = '/';

  Widget _getViewForIndex(int? index) {
    switch (index) {
      case 0:
        return const BusStopListNearby();
      case 1:
        return const BusStopListFavorites();
      default:
        return const BusStopListNearby();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);
    final localStorage = ref.watch(localStorageServiceProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Bus'),
            expandedHeight: 200,
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
      ),
    );
  }
}
