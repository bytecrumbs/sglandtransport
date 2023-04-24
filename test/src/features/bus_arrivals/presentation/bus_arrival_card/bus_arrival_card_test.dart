import 'package:flutter_test/flutter_test.dart';

import '../../bus_arrivals_robot.dart';

void main() {
  group('BusArrivalCard should', () {
    testWidgets('show a header and a sequence', (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpBusArrivalCard();
      r.expectFindBusCardDetails();
    });
  });
}
