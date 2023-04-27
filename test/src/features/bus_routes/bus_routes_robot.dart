import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/src/features/bus_routes/presentation/bus_route_tile.dart';
import 'package:lta_datamall_flutter/src/keys.dart';

class BusRoutesRobot {
  BusRoutesRobot(this.tester);

  final WidgetTester tester;

  final String busStopCode = '111222';
  final String roadName = 'Bus Road Name';
  final String description = 'Bus Description';

  Future<void> pumpBusRouteTileMiddle() async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: BusRouteTile(
              busStopCode: busStopCode,
              roadName: roadName,
              description: description,
              busSequenceType: BusSequenceType.middle,
              isPreviousStops: false,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pumpBusRouteTilePreviousStops() async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: BusRouteTile(
              busStopCode: busStopCode,
              roadName: roadName,
              description: description,
              busSequenceType: BusSequenceType.start,
              isPreviousStops: true,
            ),
          ),
        ),
      ),
    );
  }

  void expectFindBusRouteTileDetailsMiddle() {
    final descriptionFinder = find.text(description);
    expect(descriptionFinder, findsOneWidget);
    final busStopCodeAndRoadNameFinder = find.text('$busStopCode | $roadName');
    expect(busStopCodeAndRoadNameFinder, findsOneWidget);
  }

  void expectFindBusRouteTileDetailsPreviousStops() {
    final descriptionFinder = find.text(description);
    expect(descriptionFinder, findsOneWidget);
    final busStopCodeAndRoadNameFinder = find.text('$busStopCode | $roadName');
    expect(busStopCodeAndRoadNameFinder, findsNothing);
  }

  void expectFindBusRouteTileForwardArrow() {
    final finder = find.byKey(forwardArrowKey);
    expect(finder, findsOneWidget);
  }

  void expectFindNoBusRouteTileForwardArrow() {
    final finder = find.byKey(forwardArrowKey);
    expect(finder, findsNothing);
  }
}
