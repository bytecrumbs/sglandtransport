import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/staggered_animation.dart';
import 'bus_favorites_viewmodel.dart';
import 'bus_stop_card.dart';
import 'models/bus_stop_model.dart';

/// Provides the list of favorite bus stops
final favoriteBusStopsFutureProvider =
    FutureProvider<List<BusStopModel>>((ref) async {
  final vm = ref.read(busFavoritesViewModelProvider);
  return await vm.getFavoriteBusStops();
});

/// The main view that shows favorite Bus Stops
class BusFavoritesView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteBusStops = useProvider(favoriteBusStopsFutureProvider);
    return favoriteBusStops.when(
      data: (favoriteBusStops) {
        return favoriteBusStops.isEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    'No favorite bus stops found...',
                    key: ValueKey('noFavouriteBusStopsFound'),
                  ),
                ),
              )
            : AnimationLimiter(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: favoriteBusStops.length,
                    itemBuilder: (context, index) {
                      return StaggeredAnimation(
                        index: index,
                        child:
                            BusStopCard(busStopModel: favoriteBusStops[index]),
                      );
                    },
                  ),
                ),
              );
      },
      loading: () => Container(),
      // TODO: show proper error screen
      error: (error, stack) => const Text('Oops'),
    );
  }
}
