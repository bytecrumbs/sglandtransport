import 'package:flutter_test/flutter_test.dart';

import '../../bus_stops_robot.dart';

void main() {
  group('BusStopCard should', () {
    testWidgets('show bus stop distance, if allowed', (tester) async {
      final r = BusStopsRobot(tester);
      await r.pumpBusStopCardWithBusArrivalView();
      r.expectFindDistanceInMeters();
    });
    testWidgets('not show bus stop distance, if not allowed', (tester) async {
      final r = BusStopsRobot(tester);
      await r.pumpBusStopCardWithoutBusArrivalView();
      r.expectFindNoDistanceInMeters();
    });
  });
}
