import 'package:flutter_test/flutter_test.dart';

import '../../bus_stops_robot.dart';

void main() {
  group('BusStopDistance should', () {
    testWidgets('show distance if it is passed in', (tester) async {
      final r = BusStopsRobot(tester);
      await r.pumpBusStopDistance();
      r.expectFindDistanceInMeters();
    });
    testWidgets('show no distance if it is not passed in', (tester) async {
      final r = BusStopsRobot(tester);
      await r.pumpBusStopDistanceWithoutDistance();
      r.expectFindNoDistanceInMeters();
    });
  });
}
