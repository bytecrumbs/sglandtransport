import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lta_datamall_flutter/app/bus/bus_nearby_view.dart';
import 'package:lta_datamall_flutter/app/bus/bus_stop_card.dart';
import 'package:lta_datamall_flutter/app/bus/models/bus_stop_model.dart';

final busStopModel = BusStopModel(
    busStopCode: '01012',
    description: 'Hotel Grand Pacific',
    roadName: 'Victoria Street',
    distanceInMeters: 100,
    longitude: 0,
    latitude: 0);

final fakeNearbyBusStopsProvider = StreamProvider<List<BusStopModel>>(
  (ref) => Stream.value([busStopModel]),
);

void main() {
  testWidgets('Tests the nearby bus stop list', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        nearbyBusStopsProvider.overrideWithProvider(fakeNearbyBusStopsProvider)
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: BusNearbyView(),
        ),
      ),
    ));

    // The first frame is a loading state.
    // expect(find.byType(JumpingText), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);

    // Re-render. TodoListProvider should have finished fetching the todos
    // by now
    await tester.pump();

    // No-longer loading
    // expect(find.byType(JumpingText), findsNothing);
    expect(find.byType(Text), findsNothing);

    // Rendered one TodoItem with the data returned by FakeRepository
    expect(tester.widgetList(find.byType(BusStopCard)), [
      isA<BusStopCard>()
          .having((s) => s.busStopModel.busStopCode, 'busStopModel.busStopCode',
              busStopModel.busStopCode)
          .having((s) => s.busStopModel.description, 'todo.label',
              busStopModel.description)
          .having((s) => s.busStopModel.roadName, 'todo.completed',
              busStopModel.roadName)
          .having((s) => s.busStopModel.distanceInMeters,
              'busStopModel.distanceInMeters', busStopModel.distanceInMeters),
    ]);
  });
}
