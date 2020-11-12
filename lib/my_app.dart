import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/app/router.gr.dart' as auto_router;
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';
import 'package:stacked_services/stacked_services.dart';

// Toggle this for testing Crashlytics in your app locally.
final _kTestingCrashlytics = false;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _initializeFlutterFireFuture;

  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
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
    _initializeFlutterFireFuture = _initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFlutterFireFuture,
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
            title: 'SG Land Transport',
            theme: ThemeData(
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
            initialRoute: auto_router.Routes.busView,
            onGenerateRoute: auto_router.Router().onGenerateRoute,
            navigatorKey: locator<NavigationService>().navigatorKey,
            navigatorObservers: [
              locator<FirebaseAnalyticsService>().analyticsObserver,
            ],
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
