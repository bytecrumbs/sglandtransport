import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/bus_arrival_service_model.dart';
import 'package:lta_datamall_flutter/models/bus_arrival/next_bus_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_arrivals/bus_arrival_card.dart';

void main() {
  final nextBusModel = NextBusModel(
    load: 'SEA',
    estimatedArrival: '2020-02-12T14:09:11+08:00',
    destinationCode: 'destinationCode',
    feature: 'WAB',
    latitude: '1.1',
    longitude: '1.1',
    originCode: 'originCode',
    type: 'SD',
    visitNumber: 'visitNumber',
  );

  final busArrivalServiceModel = BusArrivalServiceModel(
    serviceNo: '100',
    busOperator: 'busOperator',
    nextBus: nextBusModel,
    nextBus2: nextBusModel,
    nextBus3: nextBusModel,
  );

  Future<void> _pumpBusArrivalCard({
    @required WidgetTester tester,
  }) async {
    return await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BusArrivalCard(
          busArrivalServiceModel: busArrivalServiceModel,
        ),
      ),
    ));
  }

  testWidgets('BusArrivalCard shows bus number', (WidgetTester tester) async {
    await _pumpBusArrivalCard(
      tester: tester,
    );

    expect(find.text(busArrivalServiceModel.serviceNo), findsOneWidget);
    expect(find.text('Seats Available'), findsOneWidget);
  });
}
