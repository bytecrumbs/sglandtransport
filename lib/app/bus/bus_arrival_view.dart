import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/error_view.dart';
import '../../common_widgets/staggered_animation.dart';
import '../failure.dart';
import 'bus_arrival_service_card.dart';
import 'bus_arrival_viewmodel.dart';
import 'bus_favorites_view.dart';
import 'models/bus_arrival_service_model.dart';

part 'bus_arrival_view.freezed.dart';

@freezed

/// The Timer Provider requires 2 parameters. As only one parameter can be
/// passed to it, this is a workaround to create a class that holds 2
/// parameters. Note that this is a freezed class and therefore if you make
/// changes to this, you need to run "flutter pub run build_runner build" for
/// it to have take effect
class TimerProviderParameter with _$TimerProviderParameter {
  /// Constructor for the freezed class
  factory TimerProviderParameter({
    required BuildContext context,
    required String busStopCode,
  }) = _TimerProviderParameter;
}

/// A provider that refreshes the bus arrival list every 1 minute
final timerProvider = Provider.autoDispose
    .family<void, TimerProviderParameter>((ref, timerProviderParameter) {
  Timer _timer;

  _timer = Timer.periodic(
    const Duration(minutes: 1),
    (timer) => timerProviderParameter.context.refresh(
        busArrivalServiceListFutureProvider(
            timerProviderParameter.busStopCode)),
  );
  ref.onDispose(() {
    _timer.cancel();
  });
});

/// checks if a given bus stop is already added as a favorite bus stop
final isFavoriteStateProvider =
    StateProvider.autoDispose.family<bool, String>((ref, busStopCode) {
  final vm = ref.read(busArrivalViewModelProvider);
  return vm.isFavoriteBusStop(busStopCode);
});

/// retrieves the list of bus arrival services
final busArrivalServiceListFutureProvider = FutureProvider.autoDispose
    .family<List<BusArrivalServiceModel>, String>((ref, busStopCode) async {
  final vm = ref.read(busArrivalViewModelProvider);
  return vm.getBusArrivalServiceList(busStopCode);
});

/// The main class that shows the page with all the bus arrival information
/// for a given bus stop
class BusArrivalView extends HookWidget {
  /// the constructor for the bus arrival view
  const BusArrivalView({
    Key? key,
    required this.busStopCode,
    required this.description,
  }) : super(key: key);

  /// the bus stop code for which we want to fetch arrival information
  final String busStopCode;

  /// the description of the bus stop
  final String description;

  @override
  Widget build(BuildContext context) {
    useProvider(timerProvider(TimerProviderParameter(
      context: context,
      busStopCode: busStopCode,
    )));
    final busArrivalServiceList =
        useProvider(busArrivalServiceListFutureProvider(busStopCode));
    final isFavorite = useProvider(isFavoriteStateProvider(busStopCode));
    final mv = useProvider(busArrivalViewModelProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(description),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              key: const ValueKey('favouriteIconButton'),
              icon: Icon(
                  isFavorite.state ? Icons.favorite : Icons.favorite_outline),
              onPressed: () async {
                await mv.toggleFavoriteBusStop(busStopCode);
                isFavorite.state = !isFavorite.state;
                await context.refresh(favoriteBusStopsFutureProvider);
              },
            ),
          ),
        ],
      ),
      body: busArrivalServiceList.when(
        data: (busArrivalServiceList) => RefreshIndicator(
          onRefresh: () =>
              context.refresh(busArrivalServiceListFutureProvider(busStopCode)),
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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) {
          if (err is Failure) {
            return ErrorView(message: err.message);
          }
          return const ErrorView(
            message: 'Something unexpected happened',
          );
        },
      ),
    );
  }
}
