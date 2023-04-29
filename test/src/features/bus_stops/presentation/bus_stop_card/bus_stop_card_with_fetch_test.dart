import 'package:flutter_test/flutter_test.dart';

import '../../bus_stops_robot.dart';

void main() {
  group('BusStopCardWithFetch should', () {
    testWidgets('show loading then data', (tester) async {
      final r = BusStopsRobot(tester);
      await r.pumpBusStopCardWithFetch();
      r.expectFindLoadingIndicator();
      r.expectFindNoBusListTiel();
      // ensure loading is finished
      await r.pumpMyWidget();
      r.expectFindNoLoadingIndicator();
      r.expectFindBusListTiel();
    });
  });
}
