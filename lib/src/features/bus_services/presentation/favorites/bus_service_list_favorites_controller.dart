import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/bus_arrival_config.dart';
import '../../../../shared/third_party_providers.dart';
import '../../application/bus_services_service.dart';
import '../../domain/bus_arrival_model.dart';

final busServiceListFavoritesControllerStateProvider =
    StateNotifierProvider.autoDispose<BusServiceListFavoritesController,
        AsyncValue<List<BusArrivalModel>>>(
  BusServiceListFavoritesController.new,
);

class BusServiceListFavoritesController
    extends StateNotifier<AsyncValue<List<BusArrivalModel>>> {
  BusServiceListFavoritesController(this._ref)
      : super(const AsyncValue.loading()) {
    init();
  }

  final Ref _ref;

  late final Timer _timer;

  Future<void> init({bool isRefreshing = false}) async {
    if (isRefreshing) {
      state = const AsyncValue.loading();
    }
    try {
      state = AsyncValue.data(
        await _ref.read(busServicesServiceProvider).getFavoriteBusServices(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
    _ref
        .read(loggerProvider)
        .d('starting timer for favorite bus arrival refresh');
    _timer = Timer.periodic(
      busArrivalRefreshDuration,
      (_) async {
        try {
          state = AsyncValue.data(
            await _ref
                .read(busServicesServiceProvider)
                .getFavoriteBusServices(),
          );
        } catch (e, st) {
          state = AsyncValue.error(e, st);
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _ref
        .read(loggerProvider)
        .d('cancelled timer for favorite bus arrival refresh');
    super.dispose();
  }
}
