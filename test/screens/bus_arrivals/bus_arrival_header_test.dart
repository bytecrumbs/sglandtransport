import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals/bus_arrival_header.dart';

Future<void> _pumpBusArrivalHeader(WidgetTester tester) async {
  return await tester.pumpWidget(const MaterialApp(
    home: Scaffold(
      body: BusArrivalHeader(
        headerText: 'h',
      ),
    ),
  ));
}

void main() {
  testWidgets('MyWidget has a header', (WidgetTester tester) async {
    await _pumpBusArrivalHeader(tester);
    final Finder headerFinder = find.text('h');

    expect(headerFinder, findsOneWidget);
  });
}
