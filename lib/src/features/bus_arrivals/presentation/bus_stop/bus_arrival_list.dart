import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common_widgets/error_display.dart';
import '../../../../common_widgets/staggered_animation.dart';
import '../../../../custom_exception.dart';
import '../../../../local_storage/local_storage_service.dart';
import '../../application/bus_arrivals_service.dart';
import '../../domain/bus_arrival_model.dart';
import '../bus_arrival_card/bus_arrival_card.dart';
import '../bus_arrival_config.dart';

part 'bus_arrival_list.g.dart';

@riverpod
Stream<BusArrivalModel> busArrivalsStream(
  BusArrivalsStreamRef ref, {
  required String busStopCode,
}) async* {
  final busServicesService = ref.watch(busArrivalsServiceProvider);
  // make sure it is executed immediately
  yield await busServicesService.getBusArrivals(busStopCode);
  // then execute regularly
  yield* Stream.periodic(
    busArrivalRefreshDuration,
    (computationCount) {
      return busServicesService.getBusArrivals(busStopCode);
    },
  ).asyncMap((event) async => event);
}

final lastRefreshTimeProvider = StateProvider<DateTime>((_) => DateTime.now());

final lastRefreshTimeNotifierProvider =
    StateNotifierProvider<LastRefreshTimeNotifier, DateTime>((ref) {
  final prefs = ref.watch(localStorageServiceProvider);
  return LastRefreshTimeNotifier(prefs)
    ..addListener((state) {
      ref.refresh(lastRefreshTimeProvider);
    });
});

class LastRefreshTimeNotifier extends StateNotifier<DateTime> {
  LastRefreshTimeNotifier(this.prefs) : super(DateTime.now());
  final LocalStorageService prefs;
  Future<void> refresh() async {
    state = DateTime.now();
    await prefs.setString('lastRefreshTime', state.toString());
  }
}

class BusArrivalList extends ConsumerWidget {
  const BusArrivalList({
    super.key,
    required this.busStopCode,
  });

  final String busStopCode;

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (date == today) {
      return 'Today, ${DateFormat('HH:mm').format(dateTime)}';
    } else if (date == yesterday) {
      return 'Yesterday, ${DateFormat('HH:mm').format(dateTime)}';
    } else {
      return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastRefreshTime = ref.watch(lastRefreshTimeProvider);
    final vmState = ref.watch(
      busArrivalsStreamProvider(busStopCode: busStopCode),
    );

    return Column(
      children: [
        Text(
          'Last Update: ${formatDateTime(lastRefreshTime)}',
          style: const TextStyle(fontSize: 16),
        ),
        vmState.when(
          data: (busArrival) => RefreshIndicator(
            onRefresh: () {
              ref.read(lastRefreshTimeNotifierProvider.notifier).refresh();
              ref.invalidate(
                busArrivalsStreamProvider(
                  busStopCode: busStopCode,
                ),
              );
              return Future.value();
            },
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: busArrival.services.length,
                itemBuilder: (_, index) {
                  final currentBusArrivalServicesModel =
                      busArrival.services[index];
                  return StaggeredAnimation(
                    key: Key(index.toString()),
                    index: index,
                    child: BusArrivalCard(
                      busStopCode: busStopCode,
                      destinationCode: currentBusArrivalServicesModel
                              .nextBus.destinationCode ??
                          '1',
                      inService: currentBusArrivalServicesModel.inService,
                      serviceNo: currentBusArrivalServicesModel.serviceNo,
                      destinationName:
                          currentBusArrivalServicesModel.destinationName,
                      nextBusEstimatedArrival: currentBusArrivalServicesModel
                          .nextBus
                          .getEstimatedArrival(),
                      nextBusLoad:
                          currentBusArrivalServicesModel.nextBus.load ?? 'SEA',
                      nextBus2EstimatedArrival: currentBusArrivalServicesModel
                          .nextBus2
                          .getEstimatedArrival(),
                      nextBus2Load:
                          currentBusArrivalServicesModel.nextBus2.load ?? 'SEA',
                      nextBus3EstimatedArrival: currentBusArrivalServicesModel
                          .nextBus3
                          .getEstimatedArrival(),
                      nextBus3Load:
                          currentBusArrivalServicesModel.nextBus3.load ?? 'SEA',
                    ),
                  );
                },
              ),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) {
            if (error is CustomException) {
              return ErrorDisplay(
                message: error.message,
                onPressed: () {
                  ref.invalidate(
                    busArrivalsStreamProvider(
                      busStopCode: busStopCode,
                    ),
                  );
                },
              );
            }
            return ErrorDisplay(
              message: error.toString(),
            );
          },
        ),
      ],
    );
  }
}
