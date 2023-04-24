import 'package:flutter_test/flutter_test.dart';

import '../../bus_arrivals_robot.dart';

void main() {
  group('BusArrivalSequence should', () {
    testWidgets('show bus arrival sequence if the bus is in service',
        (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpBusArrivalSequence(inService: true);
      r.expectFindBusArrivalSequence();
    });
    testWidgets("show 'Not In Operation' if bus is not in service",
        (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpBusArrivalSequence(inService: false);
      r.expectFindNotInOperation();
    });
  });
}
