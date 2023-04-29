import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/src/features/bus_stops/presentation/bus_stop_card/bus_stop_distance.dart';

class BusStopsRobot {
  BusStopsRobot(this.tester);

  final WidgetTester tester;

  final distanceInMeters = 123;

  Future<void> pumpBusStopDistance() async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: BusStopDistance(
              distanceInMeters: distanceInMeters,
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
    final finder = find.text('$distanceInMeters m');
    expect(finder, findsOneWidget);
  }

  void expectFindNoDistanceInMeters() {
    final finder = find.text('$distanceInMeters m');
    expect(finder, findsNothing);
  }
}
