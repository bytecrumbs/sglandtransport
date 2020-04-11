import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals/bus_arrival_card.dart';

Future<void> _pumpBusArrivalCard({
  @required WidgetTester tester,
  @required String serviceNo,
  @required String busOperator,
  @required String nextBusType,
  @required String nextBusLoad,
  @required String estimatedArrival,
}) async {
  return await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: BusArrivalCard(
        serviceNo: serviceNo,
        busOperator: busOperator,
        nextBusType: nextBusType,
        nextBusLoad: nextBusLoad,
        estimatedArrival: estimatedArrival,
      ),
    ),
  ));
}

void main() {
  testWidgets('BusArrivalCard shows the right text',
      (WidgetTester tester) async {
    const String serviceNo = '100';
    const String busOperator = 'SBST';
    const String nextBusType = 'SD';
    const String nextBusLoad = 'SEA';
    final String estimatedArrival = DateTime.now().toString();
    await _pumpBusArrivalCard(
      tester: tester,
      serviceNo: serviceNo,
      busOperator: busOperator,
      nextBusLoad: nextBusLoad,
      nextBusType: nextBusType,
      estimatedArrival: estimatedArrival,
    );
    final Finder serviceNoFinder = find.text(serviceNo);
    final Finder busOperatorFinder = find.text('$busOperator - Single Deck');
    final Finder busLoadFinder = find.text('Seats Available');
    final Finder estimatedArrivalFinder = find.text('Arr');

    expect(serviceNoFinder, findsOneWidget);
    expect(busOperatorFinder, findsOneWidget);
    expect(busLoadFinder, findsOneWidget);
    expect(estimatedArrivalFinder, findsOneWidget);
  });
}
