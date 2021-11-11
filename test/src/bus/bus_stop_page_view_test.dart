import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:lta_datamall_flutter/src/bus/bus_database_service.dart';
import 'package:lta_datamall_flutter/src/bus/bus_stop_list_page_view.dart';
import 'package:lta_datamall_flutter/src/bus/bus_stop_page_view.dart';
import 'package:lta_datamall_flutter/src/bus/widgets/bus_arrival_card.dart';
import 'package:lta_datamall_flutter/src/shared/common_providers.dart';
import 'package:lta_datamall_flutter/src/shared/constants.dart';
import 'package:lta_datamall_flutter/src/shared/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fakes/fake_bus_database_service.dart';
import '../../fakes/fake_dio.dart';

void main() {
  group('BusStopPageView should', () {
    const busStopCodeUnderTest = '77049';

    Future<void> _pumpWidget(WidgetTester tester) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            flareAnimationProvider.overrideWithValue(
              'Idle',
            ),
            dioProvider.overrideWithValue(
              FakeDio(),
            ),
            localStorageServiceProvider.overrideWithValue(
              LocalStorageService(sharedPreferences),
            ),
            busDatabaseServiceProvider.overrideWithValue(
              FakeBusDatabaseService(),
            ),
            loggerProvider.overrideWithValue(
              Logger(
                level: Level.error,
              ),
            )
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: BusStopPageView(
                  busStopCode: busStopCodeUnderTest, description: 'Bus Desc'),
            ),
          ),
        ),
      );
    }

    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets(
        'not show the bus stop as favorite, if it has not been stored as favorite',
        (tester) async {
      await _pumpWidget(tester);

      expect(
        find.byIcon(Icons.favorite_outline),
        findsOneWidget,
      );
      expect(
        find.byIcon(Icons.favorite),
        findsNothing,
      );
    });

    testWidgets(
        'show the bus stop as favorite, if it has been stored as favorite',
        (tester) async {
      SharedPreferences.setMockInitialValues({
        'flutter.$favoriteBusStopsKey': [busStopCodeUnderTest]
      });
      await _pumpWidget(tester);

      expect(
        find.byIcon(Icons.favorite_outline),
        findsNothing,
      );
      expect(
        find.byIcon(Icons.favorite),
        findsOneWidget,
      );
    });
    testWidgets('show loading and then data', (tester) async {
      await _pumpWidget(tester);

      // The first frame is a loading state.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for loading to complete.
      await tester.pumpAndSettle();
      // loading should be done now
      expect(find.byType(CircularProgressIndicator), findsNothing);
      // verify data is shown appropriately
      // Rendered one TodoItem with the data returned by FakeRepository
      expect(
        tester.widgetList(find.byType(BusArrivalCard)),
        [
          isA<BusArrivalCard>()
              .having((p0) => p0.busArrivalModel.serviceNo,
                  'busArrivalModel.serviceNo', '39')
              .having((p0) => p0.busArrivalModel.destinationName,
                  'busArrivalModel.destinationName', 'Dest 75019')
              .having((p0) => p0.busArrivalModel.busOperator,
                  'busArrivalModel.busOperator', 'SBST')
              .having((p0) => p0.busArrivalModel.inService,
                  'busArrivalModel.inService', true)
              .having((p0) => p0.busArrivalModel.nextBus.originCode,
                  'busArrivalModel.nextBus.originCode', '59009')
              .having(
                  (p0) => p0.busArrivalModel.nextBus.estimatedArrivalAbsolute,
                  'busArrivalModel.nextBus.estimatedArrivalAbsolute',
                  '2021-11-11T17:48:32+08:00')
              .having((p0) => p0.busArrivalModel.nextBus.latitude,
                  'busArrivalModel.nextBus.latitude', '1.3696525')
              .having((p0) => p0.busArrivalModel.nextBus.longitude,
                  'busArrivalModel.nextBus.longitude', '103.95154616666667')
              .having((p0) => p0.busArrivalModel.nextBus.visitNumber,
                  'busArrivalModel.nextBus.visitNumber', '1')
              .having((p0) => p0.busArrivalModel.nextBus.load,
                  'busArrivalModel.nextBus.load', 'SEA')
              .having((p0) => p0.busArrivalModel.nextBus.feature,
                  'busArrivalModel.nextBus.feature', 'WAB')
              .having((p0) => p0.busArrivalModel.nextBus.type,
                  'busArrivalModel.nextBus.type', 'SD'),
          isA<BusArrivalCard>()
              .having((p0) => p0.busArrivalModel.serviceNo,
                  'busArrivalModel.serviceNo', '53')
              .having((p0) => p0.busArrivalModel.destinationName,
                  'busArrivalModel.destinationName', 'Dest 53009'),
          isA<BusArrivalCard>()
              .having((p0) => p0.busArrivalModel.serviceNo,
                  'busArrivalModel.serviceNo', '53A')
              .having((p0) => p0.busArrivalModel.inService,
                  'busArrivalModel.inService', false)
              .having((p0) => p0.busArrivalModel.destinationName,
                  'busArrivalModel.destinationName', null),
          isA<BusArrivalCard>()
              .having((p0) => p0.busArrivalModel.serviceNo,
                  'busArrivalModel.serviceNo', '81')
              .having((p0) => p0.busArrivalModel.destinationName,
                  'busArrivalModel.destinationName', 'Dest 75009'),
          isA<BusArrivalCard>()
              .having((p0) => p0.busArrivalModel.serviceNo,
                  'busArrivalModel.serviceNo', '109')
              .having((p0) => p0.busArrivalModel.destinationName,
                  'busArrivalModel.destinationName', 'Dest 99009'),
          isA<BusArrivalCard>()
              .having((p0) => p0.busArrivalModel.serviceNo,
                  'busArrivalModel.serviceNo', '518')
              .having((p0) => p0.busArrivalModel.destinationName,
                  'busArrivalModel.destinationName', 'Dest 77009'),
        ],
      );
    });
  });
}
