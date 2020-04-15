import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card.dart';

Future<void> _pumpBusArrivalCard(
    {@required WidgetTester tester,
    @required String serviceNo,
    @required String nextBusLoad,
    @required String nextBusType,
    @required String nextBusFeature,
    @required String nextBusEstimatedArrival,
    @required String nextBus2EstimatedArrival,
    @required String nextBus3EstimatedArrival}) async {
  return await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: BusArrivalCard(
        serviceNo: serviceNo,
        nextBusLoad: nextBusLoad,
        nextBusType: nextBusType,
        nextBusFeature: nextBusFeature,
        nextBusEstimatedArrival: nextBusEstimatedArrival,
        nextBus2EstimatedArrival: nextBus2EstimatedArrival,
        nextBus3EstimatedArrival: nextBus3EstimatedArrival,
      ),
    ),
  ));
}

void main() {
  testWidgets('BusArrivalCard shows bus number', (WidgetTester tester) async {
    const String serviceNo = '100';
    await _pumpBusArrivalCard(
      tester: tester,
      serviceNo: serviceNo,
      nextBusType: 'DD',
      nextBusLoad: 'SEA',
      nextBusFeature: 'WAB',
      nextBusEstimatedArrival: '2020-02-12T14:09:11+08:00',
      nextBus2EstimatedArrival: '2020-02-12T14:09:11+08:00',
      nextBus3EstimatedArrival: '2020-02-12T14:09:11+08:00',
    );

    expect(find.text(serviceNo), findsOneWidget);
    expect(find.text('Seats Available'), findsOneWidget);
  });
}
