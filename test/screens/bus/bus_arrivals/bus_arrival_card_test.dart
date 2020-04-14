import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card.dart';

Future<void> _pumpBusArrivalCard(
    {@required WidgetTester tester,
    @required String serviceNo,
    @required String busOperator,
    Map<String, String> nextBus,
    Map<String, String> nextBus2,
    Map<String, String> nextBus3}) async {
  return await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: BusArrivalCard(
        serviceNo: serviceNo,
        nextBus: nextBus,
        nextBus2: nextBus2,
        nextBus3: nextBus3,
      ),
    ),
  ));
}

void main() {
  testWidgets('BusArrivalCard shows bus number', (WidgetTester tester) async {
    const String serviceNo = '100';
    const String busOperator = 'SBST';
    await _pumpBusArrivalCard(
      tester: tester,
      serviceNo: serviceNo,
      busOperator: busOperator,
      nextBus: <String, String>{
        'load': 'load',
        'type': 'type',
        'feature': 'feature',
        'estimatedArrival': '2020-02-12T14:09:11+08:00'
      },
      nextBus2: <String, String>{
        'load': 'load',
        'type': 'type',
        'feature': 'feature',
        'estimatedArrival': '2020-02-12T14:09:11+08:00'
      },
      nextBus3: <String, String>{
        'load': 'load',
        'type': 'type',
        'feature': 'feature',
        'estimatedArrival': '2020-02-12T14:09:11+08:00'
      },
    );
    final Finder serviceNoFinder = find.text(serviceNo);

    expect(serviceNoFinder, findsOneWidget);
  });
}
