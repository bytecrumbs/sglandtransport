import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../common_widgets/error_display.dart';
import '../../../../custom_exception.dart';
import '../../../../keys.dart';
import '../../../home/presentation/dashboard_screen.dart';
import '../../application/bus_stops_service.dart';
import '../../domain/bus_stop_value_model.dart';
import 'bus_stop_card.dart';

part 'bus_stop_card_with_fetch.g.dart';

@riverpod
Future<BusStopValueModel> busStop(
  BusStopRef ref, {
  required String busStopCode,
}) {
  final busStopsService = ref.watch(busStopsServiceProvider);
  return busStopsService.getBusStop(busStopCode);
}

class BusStopCardWithFetch extends ConsumerWidget {
  const BusStopCardWithFetch({
    super.key,
    required this.busStopCode,
  });

  final String busStopCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStop = ref.watch(
      busStopProvider(busStopCode: busStopCode),
    );
    return busStop.when(
      data: (busStopValueModel) => ProviderScope(
        overrides: [
          busStopValueModelProvider.overrideWithValue(busStopValueModel),
        ],
        child: const BusStopCard(
          allowBusArrivalView: false,
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(
          key: loadingIndicatorKey,
        ),
      ),
      error: (error, stack) {
        if (error is CustomException) {
          return ErrorDisplay(
            message: error.message,
            onPressed: () {
              ref.invalidate(
                busStopProvider(
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
    );
  }
}
