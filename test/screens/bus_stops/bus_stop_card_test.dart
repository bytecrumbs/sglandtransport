import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/screens/bus_stops/bus_stop_card.dart';

void main() {
  const String busStopCode = 'BusStopCode';
  const String description = 'Description';
  const String roadName = 'RoadName';
  final Function() openContainer = () {};

  Future<void> _pumpBusStopCard(WidgetTester tester) async {
    return await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BusStopCard(
          busStopCode: busStopCode,
          description: description,
          roadName: roadName,
          openContainer: openContainer,
        ),
      ),
    ));
  }

  testWidgets('Card shows a Bus Stop Code with the Bus Stop Name',
      (WidgetTester tester) async {
    await _pumpBusStopCard(tester);

    final Finder labelFinder = find.text('$busStopCode ($description)');
    expect(labelFinder, findsOneWidget);
  });

  testWidgets('Card shows a Road Name', (WidgetTester tester) async {
    await _pumpBusStopCard(tester);

    final Finder labelFinder = find.text(roadName);
    expect(labelFinder, findsOneWidget);
  });

  // TODO(anyone): Add a test that confirms the callback is called once when the widget is tapped
}
