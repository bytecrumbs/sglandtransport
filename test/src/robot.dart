import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:lta_datamall_flutter/src/app.dart';
import 'package:lta_datamall_flutter/src/features/home/presentation/dashboard_screen.dart';
import 'package:lta_datamall_flutter/src/third_party_providers/third_party_providers.dart';
import 'package:lta_datamall_flutter/src/user_location/location_service.dart';

import '../fakes/fake_location_service.dart';
import 'features/home/home_robot.dart';
import 'firebase_mocks.dart';

class Robot {
  Robot(this.tester) : home = HomeRobot(tester);

  final WidgetTester tester;
  final HomeRobot home;

  Future<void> pumpMyApp() async {
    setupFirebaseAuthMocks();

    await Firebase.initializeApp();
    final container = ProviderContainer(
      overrides: [
        locationServiceProvider.overrideWithValue(FakeLocationService()),
        flareAnimationProvider.overrideWithValue('Idle'),
        loggerProvider.overrideWithValue(
          Logger(
            printer: PrettyPrinter(),
            level: Level.error,
          ),
        ),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    );

    await tester.pump();
  }
}
