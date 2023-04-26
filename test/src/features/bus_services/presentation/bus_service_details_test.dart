import 'package:flutter_test/flutter_test.dart';

import '../../bus_arrivals/bus_arrivals_robot.dart';

void main() {
  group('BusServiceDetails should', () {
    testWidgets('show loading and then data', (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpBusServiceDetails();
      r.expectFindBusServiceDetailsLoadingIndicator();
      // ensure loading is finished
      await r.pumpMyWidget();
      r.expectFindNoBusServiceDetailsLoadingIndicator();
      r.expectFindBusOperator();
      r.expectFindBusCategory();
      r.expectFindAmPeakFreq();
      r.expectFindPmPeakFreq();
      r.expectFindAmOffpeakFreq();
      r.expectFindPmOffpeakFreq();
    });
    testWidgets('show show error when future returns an exception',
        (tester) async {
      final r = BusArrivalsRobot(tester);
      await r.pumpBusServiceDetails(produceGenericException: true);
      await r.pumpMyWidget();
      r.expectFindExceptionMessage();
    });
  });
}
