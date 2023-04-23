import 'package:flutter_test/flutter_test.dart';

import '../../bus_arrivals_robot.dart';

void main() {
  group('BusArrivalTime should', () {
    testWidgets('show the label that is passed in', (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpBusArrivalTime();
      r.expectFindEstimatedArrival();
    });
  });
}
