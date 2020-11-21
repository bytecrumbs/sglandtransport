import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/staggered_animation.dart';
import 'bus_arrival_service_card.dart';
import 'bus_arrival_viewmodel.dart';
import 'models/bus_arrival_service_model.dart';

/// retrieves the list of bus arrival services
final busArrivalServiceListFutureProvider = FutureProvider.autoDispose
    .family<List<BusArrivalServiceModel>, String>((ref, busStopCode) async {
  final vm = ref.read(busArrivalViewModelProvider);
  return await vm.getBusArrivalServiceList(busStopCode);
});

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
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(description),
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
