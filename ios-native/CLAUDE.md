# CLAUDE.md — ios-native

Guidance for Claude Code when working in `ios-native/`. This overrides general defaults for this
subproject. The repo root `../CLAUDE.md` covers the Flutter app; this file covers the native iOS
rewrite only.

## Overview

Native **SwiftUI** rewrite of the Flutter app (`lta_datamall_flutter`) — a Singapore bus-arrivals app
on the LTA Datamall API. iOS only (Android stays on Flutter for now). Goal: **1:1 feature and UX
parity** with the Flutter app, shipped as an **update to the existing App Store listing**.

Domain language and architecture rationale live in `../CONTEXT.md` (glossary) and `../docs/adr/`.
The Flutter source under `../lib/` is the **behavior-parity source of truth** — when porting, read
the named Dart file and match it.

## Confirmed decisions (apply throughout)

- **Same bundle id** `com.saschaderungs.ltaDatamall` → ships as an update, so existing users' data
  must be migrated from the Flutter `UserDefaults` `flutter.*` keys (see M4). Highest-risk item.
- **Min iOS 17.0** → use `@Observable` (Observation), `NavigationStack`, SwiftData freely.
- **SwiftData** for the local network mirror (bus stops/services/routes).
- **Hero animation rebuilt natively** in SwiftUI (the Flutter app's Flare `.flr` assets are dropped).

## Project generation — XcodeGen

`project.yml` is the **source of truth**; `SGLandTransport.xcodeproj` is **generated and gitignored**.

> **IMPORTANT:** after adding, removing, or renaming any source/resource file, run
> `xcodegen generate`. The project will not see new files until you do (a real build error I hit).

```bash
brew install xcodegen        # one-time, if missing
xcodegen generate            # regenerate the .xcodeproj from project.yml
```

## Setup & common commands

```bash
# One-time secret setup (gitignored). The app fails loudly at launch if the key is missing.
cp Configs/Secrets.example.xcconfig Configs/Secrets.local.xcconfig
#   then edit it and set LTA_DATAMALL_API_KEY  (https://datamall.lta.gov.sg/)

xcodegen generate
open SGLandTransport.xcodeproj      # then ⌘R on an iOS 17 simulator

# CLI build (simulator, no signing)
xcodebuild -scheme SGLandTransport \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.5' build CODE_SIGNING_ALLOWED=NO

# Run all tests (unit + UI) on the simulator
xcodebuild -scheme SGLandTransport \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.5' test CODE_SIGNING_ALLOWED=NO
```

- **Simulator builds need no signing** — pass `CODE_SIGNING_ALLOWED=NO` (also set in `Configs/`).
  Device/release signing is Fastlane/match, wired in M8.
- **Nearby Stops needs a location:** the simulator has no GPS. In Xcode use
  **Features ▸ Location ▸ Custom Location…** with a Singapore coordinate (e.g. `1.2845, 103.8510`).

## Secrets / config flow

`Configs/Secrets.local.xcconfig` (gitignored) → build setting `LTA_DATAMALL_API_KEY` →
`Resources/Info.plist` (`LTADatamallAPIKey`, via `$(...)` substitution) → `AppConfig`. Never hardcode
the key in Swift, and never commit `Secrets.local.xcconfig`. `BUILD_NAME` follows the same path.

## Architecture

Feature-oriented, mirroring the Flutter layering (`presentation → application → data → domain`):

```
Sources/
├── App/            # @main app, RootView shell, AppConfig, LaunchArguments, UITestSupport
├── DesignSystem/   # Palette (ported from ../lib/src/palette.dart), shared views (BottomBar)
├── Networking/     # LTAClient (URLSession + Codable), error mapping            [M2]
├── Persistence/    # SwiftData @Models, ModelContainer, refresh, queries        [M3]
├── Platform/       # Location, Firebase, Review, UserDefaults storage/migration [M1b/M4]
└── Features/       # <Feature>/ screens + @Observable services (Home, BusArrivals,
                    #   BusStops, BusServices, BusRoutes, Search, About)         [M5/M6]
Resources/          # Info.plist, Assets.xcassets
Tests/UITests/      # XCUITest suite
```

- **State / DI:** `@Observable` services injected via SwiftUI `Environment` (no Riverpod equivalent
  library — keep it plain).
- **Async:** Swift Concurrency (`async/await`, `AsyncStream` for arrival polling and location).
- **Networking:** `URLSession` + `Codable` only — no Alamofire. LTA JSON uses PascalCase keys.
- **Persistence:** SwiftData. The Flutter direction-via-`destinationCode` subquery becomes a
  two-step fetch (fetch direction, then filter). See `../lib/src/database/database.dart`.

## Conventions

- **Match the Flutter behavior exactly** when porting; cite the Dart file in a comment when the logic
  is non-obvious (e.g. the `≤59s → "Arr"` arrival rule from `next_bus_model.dart`).
- **Bug fixed during port (keep it):** the Flutter Load color key was the transposed `LDS`; the LTA
  API returns `LSD`. `BusLoad` uses the correct `LSD`. Don't reintroduce the bug.
- **Favorites format** is `busStopCode~serviceNo` (delimiter `~`), stored in `UserDefaults` — must
  stay byte-compatible with the migrated Flutter data.
- **Determinism for tests:** anything time- or network-dependent takes an injectable clock / stub
  transport. The `-uiTestStubMode` launch arg (see `LaunchArguments` / `UITestSupport`) seeds/reset
  state; extend it as features land rather than reaching for live API/GPS in tests.
- **Accessibility identifiers** for UI tests go on concrete `Text`/`Button` elements (container-level
  ids on things like `ContentUnavailableView` don't reliably surface in XCUITest).

## Testing & parity gate

- **Unit tests** (XCTest): services, query layer, time/Load logic, migration — fast, no network.
- **UI tests** (XCUITest): one test/group per feature, run under stub mode.
- **Parity gate (M5 onward):** a feature is "done" only when its UI test passes **and** its
  screenshot is signed off against the running Flutter app; signed-off screenshots become snapshot
  baselines. Tracked under `docs/parity/`.

## Milestones

Work proceeds in milestones tracked in `docs/milestones/` (`README.md` is the index with status).
M1 (skeleton) is complete; M1b (Firebase) is next. Keep the milestone files and their checklists in
sync as work lands.
