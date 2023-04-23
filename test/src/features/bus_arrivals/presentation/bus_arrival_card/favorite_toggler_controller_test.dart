import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/application/bus_arrivals_service.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/presentation/bus_arrival_card/favorite_toggler_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  const busStopCode = '111222';
  const serviceNo = '354';

  ProviderContainer makeProviderContainer(
    MockBusArrivalsService busArrivalsService,
  ) {
    final container = ProviderContainer(
      overrides: [
        busArrivalsServiceProvider.overrideWithValue(busArrivalsService),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<bool>());
  });

  group('FavoriteTogglerController should', () {
    test('set initial value and toggle', () async {
      final busArrivalsService = MockBusArrivalsService();
      // set initial value to true
      when(
        () => busArrivalsService.isFavorite(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        ),
      ).thenAnswer((_) => Future.value(true));

      // set to false when toggle
      when(
        () => busArrivalsService.toggleFavoriteBusService(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        ),
      ).thenAnswer((_) => Future.value(false));

      // setup
      final container = makeProviderContainer(busArrivalsService);
      final controller = container.read(
        favoriteTogglerControllerProvider(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        ).notifier,
      );
      final listener = Listener<AsyncValue<bool>>();
      container.listen(
        favoriteTogglerControllerProvider(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        ),
        listener.call,
        fireImmediately: true,
      );

      // run
      await container.read(
        favoriteTogglerControllerProvider(
          busStopCode: busStopCode,
          serviceNo: serviceNo,
        ).future,
      );
      await controller.toggle();

      // verify
      verifyInOrder([
        () => listener(null, const AsyncLoading<bool>()),
        () => listener(const AsyncLoading<bool>(), const AsyncData<bool>(true)),
        () =>
            listener(const AsyncData<bool>(true), const AsyncData<bool>(false)),
      ]);
      verifyNoMoreInteractions(listener);
    });
  });
}
