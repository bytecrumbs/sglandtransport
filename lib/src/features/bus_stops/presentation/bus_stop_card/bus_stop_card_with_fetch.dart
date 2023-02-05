import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/custom_exception.dart';
import '../../../../shared/presentation/error_display.dart';
import '../../../bus_services/application/bus_services_service.dart';
import '../../../home/presentation/dashboard_screen.dart';
import '../../domain/bus_stop_value_model.dart';
import 'bus_stop_card.dart';

final busStopFutureProvider =
    FutureProvider.autoDispose.family<BusStopValueModel, String>(
  (ref, busStopCode) {
    final busServicesService = ref.watch(busServicesServiceProvider);
    return busServicesService.getBusStop(busStopCode);
  },
);

class BusStopCardWithFetch extends ConsumerWidget {
  const BusStopCardWithFetch({
    super.key,
    required this.busStopCode,
  });

  final String busStopCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busStop = ref.watch(
      busStopFutureProvider(busStopCode),
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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        if (error is CustomException) {
          return ErrorDisplay(
            message: error.message,
            onPressed: () {
              ref.invalidate(
                busStopFutureProvider(
                  busStopCode,
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
