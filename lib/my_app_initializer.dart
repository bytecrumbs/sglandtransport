import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

/// Provides the view model for the MyApp class
final myAppInitializerProvider = Provider((ref) => MyAppInitializer(ref.read));

// Toggle this for testing Crashlytics in your app locally.
final _kTestingCrashlytics = false;

/// The view model for the MyApp class
class MyAppInitializer {
  /// A reader that enables reading other provdiders
  final Reader read;

  /// The default constructor of this class
  MyAppInitializer(this.read);

  static final _log = Logger('MyAppViewModel');

  /// Initializes all that needs to be done to setup firebase
  Future initFirebase() async {
    _log.info('initializing Firebase app');
    await Firebase.initializeApp();

    if (_kTestingCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // We could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    // Pass all uncaught errors to Crashlytics.
    Function originalOnError = FlutterError.onError;
    FlutterError.onError = (var errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError(errorDetails);
    };
  }

  /// Sets up layout constraints before the app fully loads
  Future initLayout() async {
    _log.info('initializing layout settings');
    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
  }
}
