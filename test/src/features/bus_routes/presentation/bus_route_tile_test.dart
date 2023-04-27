import 'package:flutter_test/flutter_test.dart';

import '../bus_routes_robot.dart';

void main() {
  group('BusRouteTile should', () {
    testWidgets(
        'should show bus stop code, roadname and description if it is a regular tile',
        (tester) async {
      final r = BusRoutesRobot(tester);
      await r.pumpBusRouteTileMiddle();
      r.expectFindBusRouteTileDetailsMiddle();
    });
    testWidgets(
        'should description only if it is a tile indicating more previous bus stops',
        (tester) async {
      final r = BusRoutesRobot(tester);
      await r.pumpBusRouteTilePreviousStops();
      r.expectFindBusRouteTileDetailsPreviousStops();
    });
    testWidgets('should show a forward arrow if it is a regular tile',
        (tester) async {
      final r = BusRoutesRobot(tester);
      await r.pumpBusRouteTileMiddle();
      r.expectFindBusRouteTileForwardArrow();
    });
    testWidgets(
        'should not show a forward arrow if it is a tile indicating more previous bus stops',
        (tester) async {
      final r = BusRoutesRobot(tester);
      await r.pumpBusRouteTilePreviousStops();
      r.expectFindNoBusRouteTileForwardArrow();
    });
  });
}
