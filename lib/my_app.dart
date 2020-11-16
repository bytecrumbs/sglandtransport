import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routing/router.gr.dart' as auto_route;

// Toggle this for testing Crashlytics in your app locally.
final _kTestingCrashlytics = false;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  Future<void> _initializeSgLandTransportFuture;

  // Define an async function to initialize FlutterFire
  Future<void> _initializeSgLandTransport() async {
    // Wait for Firebase to initialize
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
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      // Forward to original handler.
      originalOnError(errorDetails);
    };

    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void initState() {
    super.initState();
    _initializeSgLandTransportFuture = _initializeSgLandTransport();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeSgLandTransportFuture,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Something went wrong')),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'GitLab Mobile',
            builder: ExtendedNavigator.builder(
              router: auto_route.Router(),
              observers: <NavigatorObserver>[observer],
              builder: (context, extendedNav) => Theme(
                data: ThemeData(
                  brightness: Brightness.light,
                  primaryColorDark: Color(0xFF25304D),
                  primaryColor: Color(0xFF969CAE),
                  accentColor: Color(0xFFEF3340),
                  scaffoldBackgroundColor: Color(0xFFE2EFF5),
                  textTheme: TextTheme(
                    headline1: TextStyle(
                      color: Color(0xFF25304D),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    headline2: TextStyle(
                      color: Color(0xFF8C8C91),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                child: extendedNav,
              ),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Scaffold(),
        );
      },
    );
  }
}
