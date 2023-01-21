import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/bus_arrival_config.dart';
import '../../../../shared/third_party_providers.dart';
import '../../application/bus_services_service.dart';
import '../../domain/bus_arrival_model.dart';

final busServicesListScreenControllerStateNotifierProvider =
    StateNotifierProvider.autoDispose.family<BusServicesListScreenController,
        AsyncValue<BusArrivalModel>, String>(
  BusServicesListScreenController.new,
);

class BusServicesListScreenController
    extends StateNotifier<AsyncValue<BusArrivalModel>> {
  BusServicesListScreenController(this._ref, this._busStopCode)
      : super(const AsyncValue.loading()) {
    init();
  }

  final Ref _ref;
  final String _busStopCode;

  late final Timer _timer;

  Future<void> init({bool isRefreshing = false}) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      state = AsyncValue.data(
        await _ref
            .read(busServicesServiceProvider)
            .getBusArrivals(_busStopCode),
      );
      _ref.read(loggerProvider).d('starting timer for bus arrival refresh');
      _timer = Timer.periodic(
        busArrivalRefreshDuration,
        (_) async {
          state = AsyncValue.data(
            await _ref
                .read(busServicesServiceProvider)
                .getBusArrivals(_busStopCode),
          );
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _ref.read(loggerProvider).d('cancelled timer for bus arrival refresh');
    super.dispose();
  }
}
