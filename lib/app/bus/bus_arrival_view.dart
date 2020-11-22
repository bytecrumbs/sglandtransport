import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/staggered_animation.dart';
import 'bus_arrival_service_card.dart';
import 'bus_arrival_viewmodel.dart';
import 'bus_favorites_view.dart';
import 'models/bus_arrival_service_model.dart';

/// checks if a given bus stop is already added as a favorite bus stop
final isFavoriteFutureProvider =
    FutureProvider.family<bool, String>((ref, busStopCode) async {
  final vm = ref.read(busArrivalViewModelProvider);
  return await vm.isFavoriteBusStop(busStopCode);
});

/// retrieves the list of bus arrival services
final busArrivalServiceListFutureProvider = FutureProvider.autoDispose
    .family<List<BusArrivalServiceModel>, String>((ref, busStopCode) async {
  final vm = ref.read(busArrivalViewModelProvider);
  return await vm.getBusArrivalServiceList(busStopCode);
});

// TODO: figure out how to do an auto refresh every minute

/// The main class that shows the page with all the bus arrival information
/// for a given bus stop
class BusArrivalView extends HookWidget {
  /// the bus stop code for which we want to fetch arrival information
  final String busStopCode;

  /// the description of the bus stop
  final String description;

  /// the constructor for the bus arrival view
  const BusArrivalView({
    Key key,
    this.busStopCode,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var busArrivalServiceList =
        useProvider(busArrivalServiceListFutureProvider(busStopCode));
    var isFavorite = useProvider(isFavoriteFutureProvider(busStopCode));
    var mv = useProvider(busArrivalViewModelProvider);
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(description),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: isFavorite.when(
                  data: (isFavorite) => IconButton(
                      icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline),
                      onPressed: () async {
                        await mv.toggleFavoriteBusStop(busStopCode);
                        context.refresh(isFavoriteFutureProvider(busStopCode));
                        context.refresh(favoriteBusStopsFutureProvider);
                      }),
                  loading: () => Icon(Icons.favorite_outline),
                  error: (error, stack) => Icon(Icons.favorite_outline)),
            ),
          ],
        ),
        body: busArrivalServiceList.when(
          data: (busArrivalServiceList) => RefreshIndicator(
            onRefresh: () => context
                .refresh(busArrivalServiceListFutureProvider(busStopCode)),
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: busArrivalServiceList.length,
                itemBuilder: (context, index) {
                  return StaggeredAnimation(
                    index: index,
                    child: BusArrivalServiceCard(
                      busArrivalServiceModel: busArrivalServiceList[index],
                      key: ValueKey<String>('busArrivalCard-$index'),
                    ),
                  );
                },
              ),
            ),
          ),

          loading: () => Center(child: CircularProgressIndicator()),
          // TODO: show proper error screen
          error: (error, stack) => const Text('Oops'),
        ));
  }
}
