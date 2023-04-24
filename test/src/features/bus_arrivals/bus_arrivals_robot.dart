import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/presentation/bus_arrival_card/bus_arrival_card_header.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/presentation/bus_arrival_card/bus_arrival_sequence.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/presentation/bus_arrival_card/bus_arrival_time.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/presentation/bus_arrival_card/favorite_toggler.dart';
import 'package:lta_datamall_flutter/src/keys.dart';
import 'package:lta_datamall_flutter/src/local_storage/local_storage_keys.dart';
import 'package:lta_datamall_flutter/src/third_party_providers/third_party_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusArrivalsRobot {
  BusArrivalsRobot(this.tester);

  final WidgetTester tester;

  final String serviceNo = '354';
  final String destinationName = '354 Destination';
  final String busStopCode = '111222';
  final String estimatedArrival = '3min';
  final String busLoad = 'SEA';
  final String estimatedArrival2 = '6min';
  final String busLoad2 = 'SDA';
  final String estimatedArrival3 = '9min';
  final String busLoad3 = 'LDS';

  Future<void> pumpBusArrivalCardHeaderNotInService() async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: BusArrivalCardHeader(
              serviceNo: serviceNo,
              inService: false,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpBusArrivalCardHeaderInService() async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: BusArrivalCardHeader(
              serviceNo: serviceNo,
              inService: true,
              destinationName: destinationName,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpBusArrivalTime() async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: BusArrivalTime(
              estimatedArrival: estimatedArrival,
              busLoad: busLoad,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpBusArrivalSequence({required bool inService}) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: BusArrivalSequence(
              inService: inService,
              nextBusEstimatedArrival: estimatedArrival,
              nextBusLoad: busLoad,
              nextBus2EstimatedArrival: estimatedArrival2,
              nextBus2Load: busLoad2,
              nextBus3EstimatedArrival: estimatedArrival3,
              nextBus3Load: busLoad3,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpFavoriteTogglerWithActivatedFavorite() async {
    SharedPreferences.setMockInitialValues({
      favoriteServiceNoKey: [
        '$busStopCode$busStopCodeServiceNoDelimiter$serviceNo',
      ]
    });

    final container = ProviderContainer(
      overrides: [
        loggerProvider.overrideWithValue(
          Logger(
            printer: PrettyPrinter(),
            level: Level.error,
          ),
        )
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: FavoriteToggler(
              serviceNo: serviceNo,
              busStopCode: busStopCode,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> pumpFavoriteTogglerWithoutFavorite() async {
    SharedPreferences.setMockInitialValues({});

    final container = ProviderContainer(
      overrides: [
        loggerProvider.overrideWithValue(
          Logger(
            printer: PrettyPrinter(),
            level: Level.error,
          ),
        )
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: FavoriteToggler(
              serviceNo: serviceNo,
              busStopCode: busStopCode,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  void expectFindNotInOperation() {
    final arrival1 = find.text(estimatedArrival);
    expect(arrival1, findsNothing);
    final arrival2 = find.text(estimatedArrival2);
    expect(arrival2, findsNothing);
    final arrival3 = find.text(estimatedArrival3);
    expect(arrival3, findsNothing);

    final finder = find.text('Not In Operation');
    expect(finder, findsOneWidget);
  }

  void expectFindBusArrivalSequence() {
    final arrival1 = find.text(estimatedArrival);
    expect(arrival1, findsOneWidget);
    final arrival2 = find.text(estimatedArrival2);
    expect(arrival2, findsOneWidget);
    final arrival3 = find.text(estimatedArrival3);
    expect(arrival3, findsOneWidget);
  }

  void expectFindEstimatedArrival() {
    final finder = find.text(estimatedArrival);
    expect(finder, findsOneWidget);
  }

  void expectFindNoDestination() {
    final destinationLabel = 'to $destinationName';
    final finder = find.text(destinationLabel);
    expect(finder, findsNothing);
  }

  void expectFindDestination() {
    final destinationLabel = 'to $destinationName';
    final finder = find.text(destinationLabel);
    expect(finder, findsOneWidget);
  }

  void expectFindServiceNo() {
    final finder = find.text(serviceNo);
    expect(finder, findsOneWidget);
  }

  void expectFindFavoriteIndicator() {
    final finder = find.byKey(isFavoriteIconKey);
    expect(finder, findsOneWidget);
  }

  void expectFindNoFavoriteIndicator() {
    final finder = find.byKey(isFavoriteIconKey);
    expect(finder, findsNothing);
  }

  Future<void> tapFavoriteButton() async {
    final button = find.byKey(favoriteButtonKey);
    await tester.tap(button);
    await tester.pump();
  }
}
