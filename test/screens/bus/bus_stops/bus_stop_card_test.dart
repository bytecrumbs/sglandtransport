import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus/bus_stops/bus_stop_card.dart';

void main() {
  final BusStopModel busStopModel = BusStopModel(
    'BusStopCode',
    'RoadName',
    'Description',
    1.1,
    1.2,
  );

  final Function() openContainer = () {
    print('Callback called');
  };

  Future<void> _pumpBusStopCard(WidgetTester tester) async {
    return await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BusStopCard(
          busStopModel: busStopModel,
          openContainer: openContainer,
        ),
      ),
    ));
  }

  testWidgets('Card shows a Bus Stop Code with the Bus Stop Name',
      (WidgetTester tester) async {
    await _pumpBusStopCard(tester);

    final Finder labelFinder =
        find.text('${busStopModel.busStopCode} (${busStopModel.roadName})');
    expect(labelFinder, findsOneWidget);
  });

  testWidgets('Card shows a description', (WidgetTester tester) async {
    await _pumpBusStopCard(tester);

    final Finder labelFinder = find.text(busStopModel.description);
    expect(labelFinder, findsOneWidget);
  });

  testWidgets('Callback is called when Card is clicked',
      (WidgetTester tester) async {
    await _pumpBusStopCard(tester);

    expect(
      () => tester.tap(find.text(busStopModel.description)),
      prints('Callback called\n'),
    );
  });
}
