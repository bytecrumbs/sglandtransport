import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals/bus_arrival_header.dart';

Future<void> _pumpBusArrivalHeader(
    WidgetTester tester, String headerText) async {
  return await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: BusArrivalHeader(
        headerText: headerText,
      ),
    ),
  ));
}

void main() {
  testWidgets('MyWidget has a header', (WidgetTester tester) async {
    const String headerText = 'h';
    await _pumpBusArrivalHeader(tester, headerText);
    final Finder headerFinder = find.text(headerText);

    expect(headerFinder, findsOneWidget);
  });
}
