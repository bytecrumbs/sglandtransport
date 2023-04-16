import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logger/logger.dart';
import 'package:lta_datamall_flutter/firebase_options.dart';
import 'package:lta_datamall_flutter/src/app.dart';
import 'package:lta_datamall_flutter/src/features/home/presentation/dashboard_screen.dart';
import 'package:lta_datamall_flutter/src/third_party_providers/third_party_providers.dart';
import 'package:lta_datamall_flutter/src/user_location/fake_location_service.dart';
import 'package:lta_datamall_flutter/src/user_location/location_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test should', () {
    testWidgets('verify loading', (tester) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final container = ProviderContainer(
        overrides: [
          locationServiceProvider.overrideWithValue(FakeLocationService()),
          flareAnimationProvider.overrideWithValue('Idle'),
          loggerProvider.overrideWithValue(
            Logger(
              printer: PrettyPrinter(),
              level: Level.error,
            ),
          )
        ],
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('SG Land Transport'), findsOneWidget);
    });
  });
}
