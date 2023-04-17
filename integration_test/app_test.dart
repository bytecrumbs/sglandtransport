import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/src/robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test should', () {
    testWidgets('verify loading', (tester) async {
      final r = Robot(tester);
      await r.pumpMyApp();
      r.home.expectAppTitleToBeShown();
    });
  });
}
