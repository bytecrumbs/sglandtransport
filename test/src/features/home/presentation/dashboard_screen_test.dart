import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../robot.dart';

void main() {
  group('DashboardScreen should', () {
    testWidgets('show the app title', (tester) async {
      await tester.runAsync(() async {
        SharedPreferences.setMockInitialValues({});
        final r = Robot(tester);
        await r.pumpMyApp();
        r.home.expectAppTitleToBeShown();
      });
    });
  });
}
