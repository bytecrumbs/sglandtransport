import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:lta_datamall_flutter/src/database/database.dart';
import 'package:lta_datamall_flutter/src/features/bus_routes/presentation/bus_route.dart';
import 'package:lta_datamall_flutter/src/features/bus_routes/presentation/bus_route_tile.dart';
import 'package:lta_datamall_flutter/src/keys.dart';
import 'package:lta_datamall_flutter/src/third_party_providers/third_party_providers.dart';

import '../../../fakes/fake_database.dart';

class BusRoutesRobot {
  BusRoutesRobot(this.tester);

  final WidgetTester tester;

  final String serviceNo = '354';
  final String busStopCode = '111222';
  final String roadName = 'Bus Road Name';
  final String description = 'Bus Description';
  final String destinationCode = '97009';

  Future<void> pumpMyWidget() async {
    await tester.pumpAndSettle();
  }

  Future<void> pumpBusRoute({
    bool produceGenericException = false,
  }) async {
    final container = ProviderContainer(
      overrides: [
        loggerProvider.overrideWithValue(
          Logger(
            printer: PrettyPrinter(),
            level: Level.error,
          ),
        ),
        appDatabaseProvider.overrideWithValue(FakeAppDatabase()),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: BusRoute(
              busStopCode: busStopCode,
              destinationCode: destinationCode,
              serviceNo: serviceNo,
            ),
          ),
        ),
      ),
    );
  }

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

  void expectFindBusRoute() {
    expectFindBusRouteTileDetailsMiddle(
      inputBusStopCode: fakeBusRouteWithBusStopInfoModelList[0].busStopCode,
      inputDescription: fakeBusRouteWithBusStopInfoModelList[0].description,
      inputRoadName: fakeBusRouteWithBusStopInfoModelList[0].roadName,
    );
    expectFindBusRouteTileDetailsMiddle(
      inputBusStopCode: fakeBusRouteWithBusStopInfoModelList[1].busStopCode,
      inputDescription: fakeBusRouteWithBusStopInfoModelList[1].description,
      inputRoadName: fakeBusRouteWithBusStopInfoModelList[1].roadName,
    );
    expectFindBusRouteTileDetailsPreviousStops(
      inputDescription:
          '${fakeBusRouteWithBusStopInfoModelList[0].stopSequence - 1} previous stops',
    );
  }

  void expectFindBusServiceRouteLoadingIndicator() {
    _expectFindLoadingIndicator(loadingIndicatorKey);
  }

  void _expectFindLoadingIndicator(Key loadingIndicatorKey) {
    final finder = find.byKey(loadingIndicatorKey);
    expect(finder, findsOneWidget);
  }

  void expectFindNoBusServiceRouteLoadingIndicator() {
    _expectFindNoLoadingIndicator(loadingIndicatorKey);
  }

  void _expectFindNoLoadingIndicator(Key loadingIndicatorKey) {
    final finder = find.byKey(loadingIndicatorKey);
    expect(finder, findsNothing);
  }

  void expectFindBusRouteTileDetailsMiddle({
    String? inputDescription,
    String? inputBusStopCode,
    String? inputRoadName,
  }) {
    final findDescription = inputDescription ?? description;
    final findBusStopCode = inputBusStopCode ?? busStopCode;
    final findRoadName = inputRoadName ?? roadName;

    final descriptionFinder = find.text(findDescription);
    expect(descriptionFinder, findsOneWidget);
    final busStopCodeAndRoadNameFinder =
        find.text('$findBusStopCode | $findRoadName');
    expect(busStopCodeAndRoadNameFinder, findsOneWidget);
  }

  void expectFindBusRouteTileDetailsPreviousStops({
    String? inputDescription,
    String? inputBusStopCode,
    String? inputRoadName,
  }) {
    final findDescription = inputDescription ?? description;
    final findBusStopCode = inputBusStopCode ?? busStopCode;
    final findRoadName = inputRoadName ?? roadName;

    final descriptionFinder = find.text(findDescription);
    expect(descriptionFinder, findsOneWidget);
    final busStopCodeAndRoadNameFinder =
        find.text('$findBusStopCode | $findRoadName');
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
