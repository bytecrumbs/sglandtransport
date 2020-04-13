import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card.dart';

Future<void> _pumpBusArrivalCard(
    {@required WidgetTester tester,
    @required String serviceNo,
    @required String busOperator,
    Map<String, Map> nextBusesDetails}) async {
  return await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: BusArrivalCard(
        serviceNo: serviceNo,
        busOperator: busOperator,
        nextBusesDetails: nextBusesDetails,
      ),
    ),
  ));
}

void main() {
  testWidgets('BusArrivalCard shows the right text',
      (WidgetTester tester) async {
    const String serviceNo = '100';
    const String busOperator = 'SBST';
    await _pumpBusArrivalCard(
      tester: tester,
      serviceNo: serviceNo,
      busOperator: busOperator,
      nextBusesDetails: {
        'nextBus': <String, String>{
          'load': 'load',
          'type': 'type',
          'feature': 'feature',
          'estimatedArrival': 'estimatedArrival'
        },
        'nextBus2': <String, String>{
          'load': 'load',
          'type': 'type',
          'feature': 'feature',
          'estimatedArrival': 'estimatedArrival'
        },
        'nextBus3': <String, String>{
          'load': 'load',
          'type': 'type',
          'feature': 'feature',
          'estimatedArrival': 'estimatedArrival'
        }
      },
    );
    final Finder serviceNoFinder = find.text(serviceNo);
    final Finder busOperatorFinder = find.text('$busOperator');

    expect(serviceNoFinder, findsOneWidget);
    expect(busOperatorFinder, findsOneWidget);
  });
}
