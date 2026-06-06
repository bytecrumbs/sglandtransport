# M1b — Firebase (SPM) + GoogleService-Info + Crashlytics wiring

**Status:** ⬜ Pending
**Depends on:** M1

## Goal

Crash, analytics, performance, and remote-config reporting wired before real feature code lands, so
errors are captured from the start. Reuses the existing Firebase project (no new console setup).

## Scope

- [ ] Add **Firebase Apple SDK** via Swift Package Manager (`firebase-ios-sdk`) to `project.yml`:
      products `FirebaseCrashlytics`, `FirebaseAnalytics`, `FirebasePerformance`,
      `FirebaseRemoteConfig`. (First step needing network for package resolution.)
- [ ] Add the existing **`GoogleService-Info.plist`** (from `ios/Runner/GoogleService-Info.plist`,
      project `lta-datamall`, bundle id `com.saschaderungs.ltaDatamall`) to the app target.
- [ ] Add the Crashlytics **dSYM upload / run-script** build phase (required for symbolicated crashes).
- [ ] `FirebaseApp.configure()` at launch; **disable Crashlytics collection in Debug** (parity with
      the Flutter `!kDebugMode`); enable in Release.
- [ ] Wire fatal handlers (parity with `lib/main.dart`): route uncaught Swift errors / `NSException`
      to Crashlytics.
- [ ] `RemoteConfigService` (`@Observable`): default `show_last_refresh_time = false`, 10s fetch
      timeout, `fetchAndActivate` on launch, `getLastRefreshTime()`. Ref:
      `lib/src/features/firebase/remote_config_service.dart`.
- [ ] Analytics: screen-view logging hook (used by navigation in M5/M6) + a `logSearch` seam.
      Ref: `app_router.dart` (FirebaseAnalyticsObserver), `custom_search_delegate.dart`.
- [ ] In `-uiTestStubMode`, no-op/route Firebase so UI tests stay offline and deterministic.

## Out of scope

- Performance custom traces (the Flutter app uses auto-instrumentation only — match that).

## Verification

- App builds and runs on simulator with Firebase linked; no crash on launch.
- A forced test crash (Release-style config) appears in the Firebase Crashlytics console.
- Remote Config fetch succeeds; `getLastRefreshTime()` returns the configured value.
- Smoke UI tests still pass under stub mode (Firebase calls no-op).
