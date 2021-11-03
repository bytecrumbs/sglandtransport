import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';
import 'src/shared/services/local_storage_service.dart';

// Toggle this for testing Crashlytics in the app locally.
const _kTestingCrashlytics = false;

// TODO: add app review functionality (in_app_review or rate_my_app)

// TODO: investigate the isSmallScreen logic across the app. currently, I have not implemented this.

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp();
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      if (_kTestingCrashlytics) {
        // Force enable crashlytics collection enabled if we're testing it.
        await FirebaseCrashlytics.instance
            .setCrashlyticsCollectionEnabled(true);
      } else {
        // Else only enable it in non-debug builds.
        // We could additionally extend this to allow users to opt-in.
        await FirebaseCrashlytics.instance
            .setCrashlyticsCollectionEnabled(!kDebugMode);
      }

      final sharedPreferences = await SharedPreferences.getInstance();

      // Setup flare
      FlareCache.doesPrune = false;
      await cachedActor(
          AssetFlare(bundle: rootBundle, name: 'images/city.flr'));

      runApp(
        ProviderScope(
          overrides: [
            localStorageServiceProvider.overrideWithValue(
              LocalStorageService(sharedPreferences),
            )
          ],
          child: const MyApp(),
        ),
      );
    },
    (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
