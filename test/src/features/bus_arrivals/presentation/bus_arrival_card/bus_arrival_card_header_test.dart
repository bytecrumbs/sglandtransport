import 'package:flutter_test/flutter_test.dart';

import '../../bus_arrivals_robot.dart';

void main() {
  group('BusArrivalCardHeader should', () {
    testWidgets(
        'show the service number but no destination when bus is not in service',
        (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpBusArrivalCardHeaderNotInService();
      r.expectFindServiceNo();
      r.expectFindNoDestination();
    });

    testWidgets(
        'show the service number and destination when bus is in service',
        (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpBusArrivalCardHeaderInService();
      r.expectFindServiceNo();
      r.expectFindDestination();
    });
  });
}
