import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_details.dart';

Future<void> _pumpBusArrivalDetails(
    {@required WidgetTester tester,
    @required Map<String, dynamic> busDetails}) async {
  return await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: BusArrivalDetails(busDetails: busDetails),
    ),
  ));
}

void main() {
  testWidgets('Displays information about bus', (WidgetTester tester) async {
    await _pumpBusArrivalDetails(tester: tester, busDetails: <String, dynamic>{
      'load': 'SEA',
      'type': 'DD',
      'feature': 'WAB',
      'estimatedArrival': '2020-02-12T14:09:11+08:00'
    });

    expect(find.text('Wheelchair Accessible'), findsOneWidget);
    expect(find.text('Seats\nAvailable'), findsOneWidget);
  });
}
