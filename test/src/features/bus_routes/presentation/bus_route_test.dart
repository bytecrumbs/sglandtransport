import 'package:flutter_test/flutter_test.dart';

import '../bus_routes_robot.dart';

void main() {
  group('BusRoute should', () {
    testWidgets('show loading and then data', (tester) async {
      final r = BusRoutesRobot(tester);
      await r.pumpBusRoute();
      r.expectFindBusServiceRouteLoadingIndicator();
      // ensure loading is finished
      await r.pumpMyWidget();
      r.expectFindNoBusServiceRouteLoadingIndicator();
      r.expectFindBusRoute();
    });
  });
}
