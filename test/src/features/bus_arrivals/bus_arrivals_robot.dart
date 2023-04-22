import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/src/features/bus_arrivals/presentation/bus_arrival_card/bus_arrival_card_header.dart';

class BusArrivalsRobot {
  BusArrivalsRobot(this.tester);

  final WidgetTester tester;

  final String serviceNo = '354';
  final String destinationName = '354 Destination';

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
}
