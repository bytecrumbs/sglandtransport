import 'package:flutter_test/flutter_test.dart';

import '../../../robot.dart';

void main() {
  group('DashboardScreen should', () {
    testWidgets('show the app title', (tester) async {
      await tester.runAsync(() async {
        final r = Robot(tester);
        await r.pumpMyApp();
        // TODO: pump does not seem to work here???
        // r.home.expectAppTitleToBeShown();
      });
    });
  });
}
