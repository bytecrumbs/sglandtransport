import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/src/features/bus_stops/data/bus_stops_repository.dart';
import 'package:lta_datamall_flutter/src/features/bus_stops/presentation/bus_stop_card/bus_stop_card.dart';
import 'package:lta_datamall_flutter/src/features/bus_stops/presentation/bus_stop_card/bus_stop_card_with_fetch.dart';
import 'package:lta_datamall_flutter/src/features/bus_stops/presentation/bus_stop_card/bus_stop_distance.dart';
import 'package:lta_datamall_flutter/src/features/home/presentation/dashboard_screen.dart';
import 'package:lta_datamall_flutter/src/keys.dart';

import '../../../fakes/fake_bus_stops_repository.dart';

class BusStopsRobot {
  BusStopsRobot(this.tester);

  final WidgetTester tester;

  Future<void> pumpMyWidget() async {
    await tester.pumpAndSettle();
  }

  Future<void> pumpBusStopCardWithFetch() async {
    final container = ProviderContainer(
      overrides: [
        busStopsRepositoryProvider.overrideWithValue(FakeBusStopsRepository())
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: BusStopCardWithFetch(
              busStopCode: fakeBusStopValueModel.busStopCode,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpBusStopCardWithBusArrivalView() async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          busStopValueModelProvider.overrideWithValue(fakeBusStopValueModel)
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: BusStopCard(),
          ),
        ),
      ),
    );
  }

  Future<void> pumpBusStopCardWithoutBusArrivalView() async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          busStopValueModelProvider.overrideWithValue(fakeBusStopValueModel)
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: BusStopCard(allowBusArrivalView: false),
          ),
        ),
      ),
    );
  }

  Future<void> pumpBusStopDistance() async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: BusStopDistance(
              distanceInMeters: fakeBusStopValueModel.distanceInMeters,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpBusStopDistanceWithoutDistance() async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: BusStopDistance(),
          ),
        ),
      ),
    );
  }

  void expectFindDistanceInMeters() {
    final finder = find.text('${fakeBusStopValueModel.distanceInMeters} m');
    expect(finder, findsOneWidget);
  }

  void expectFindNoDistanceInMeters() {
    final finder = find.text('${fakeBusStopValueModel.distanceInMeters} m');
    expect(finder, findsNothing);
  }

  void expectFindLoadingIndicator() {
    final finder = find.byKey(loadingIndicatorKey);
    expect(finder, findsOneWidget);
  }

  void expectFindNoLoadingIndicator() {
    final finder = find.byKey(loadingIndicatorKey);
    expect(finder, findsNothing);
  }

  void expectFindBusListTiel() {
    final finder = find.byType(ListTile);
    expect(finder, findsOneWidget);
  }

  void expectFindNoBusListTiel() {
    final finder = find.byType(ListTile);
    expect(finder, findsNothing);
  }
}
