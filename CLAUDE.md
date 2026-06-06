# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Flutter app (Android, iOS, web, desktop) for Singapore public transport, built on the
[LTA Datamall](https://datamall.lta.gov.sg) APIs. The Dart package name is `lta_datamall_flutter`.

## Requirements

The app reads the LTA Datamall API key from a `--dart-define` named `LTA_DATAMALL_API_KEY`
(see `lib/environment_config.dart`). Requests fail with an `AssertionError` if it is unset.
The conventional way to supply it locally is an `api-keys.json` file in the project root:

```json
{ "LTA_DATAMALL_API_KEY": "your-key" }
```

## Common commands

```bash
# Run (VSCode launch.json "debug mode" passes api-keys.json automatically)
flutter run --dart-define-from-file=api-keys.json

# Code generation — REQUIRED after changing any model, repository provider,
# Drift table, or Riverpod-annotated provider (generates *.g.dart, *.freezed.dart)
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch --delete-conflicting-outputs   # regenerate on change

# Static analysis (lint config is strict — see analysis_options.yaml)
flutter analyze

# Tests
flutter test
flutter test --coverage
flutter test test/src/features/bus_arrivals/application/bus_arrivals_service_test.dart   # single file
flutter test --name "Sort bus stops by distance"                                          # single test by name

# Verify every lib file has a corresponding test file (CI enforces this; fails the build otherwise)
sh scripts/import_files_coverage.sh lta_datamall_flutter

# Integration / UI tests
flutter drive --target=test_driver/app.dart --dart-define=LTA_DATAMALL_API_KEY=<key>
```

CI (`.github/workflows/test.yml`) runs on PRs to `master`: `build_runner build` → `flutter analyze`
→ `import_files_coverage.sh` → `flutter test --coverage`. Note the README mentions
`prepare_test_coverage.sh`, but the actual script lives at `scripts/import_files_coverage.sh`.

## Architecture

Feature-first layout under `lib/src/features/<feature>/`, each feature split into the same four layers:

- **`domain/`** — immutable models (Freezed + `json_serializable`), e.g. `bus_arrival_model.dart`.
- **`data/`** — repositories that talk to the outside world. API repositories extend
  `BaseRepository` (`lib/src/features/shared/data/base_repository.dart`), which centralizes the Dio
  call, injects the `AccountKey` header, and converts `DioException` into `CustomException`.
- **`application/`** — services holding business logic that compose repositories (e.g.
  `BusArrivalsService` merges live arrivals with not-in-operation services and sorts by distance).
- **`presentation/`** — `ConsumerWidget` screens/widgets that `ref.watch` providers.

Dependencies flow presentation → application → data → domain. Cross-feature reuse is common
(e.g. `bus_arrivals` reads `bus_routes` and `bus_stops` repositories).

### State management & DI — Riverpod

Everything is wired through Riverpod providers. Repositories and services are exposed as
`Provider`s constructed with `ref` (`BusArrivalsRepository(this.ref)`), and read via
`ref.read(...Provider)`. Cross-cutting infrastructure lives in
`lib/src/third_party_providers/third_party_providers.dart` (`dioProvider`, `loggerProvider`).
Some providers use `riverpod_annotation` codegen (`@riverpod`, generates `*.g.dart`).
Tests override providers via a `ProviderContainer(overrides: [...])` and `addTearDown(container.dispose)`.

### Local persistence — Drift (SQLite)

`lib/src/database/database.dart` defines `AppDatabase` (`@DriftDatabase`, tables in `tables.dart`,
exposed via `appDatabaseProvider`). The DB caches bus routes/stops/services pulled from the API and
refreshes them on a schedule via the `MigrationStrategy.beforeOpen` hook, using
`LocalStorageService` (shared_preferences wrapper) to track the refresh date. Simple key/value state
uses `lib/src/local_storage/` rather than Drift.

### Routing — go_router

Single `goRouter` in `lib/src/routing/app_router.dart`. Routes are named via the `AppRoute` enum and
nested under `/`. A `FirebaseAnalyticsObserver` is attached for screen tracking.

### App entry

`lib/main.dart` initializes Firebase (Crashlytics wired to `FlutterError.onError` and
`PlatformDispatcher.onError`), preloads the Flare animation asset, and runs `MyApp` inside a
`ProviderScope`. `lib/src/app.dart` builds the `MaterialApp.router`.

## Conventions

- **Lint is strict and intentional**: `analysis_options.yaml` includes `all_lint_rules.yaml`
  (nearly every rule on) plus `custom_lint`/`riverpod_lint`, with `strict-casts`, `strict-inference`,
  and `strict-raw-types` enabled. Read the override comments in `analysis_options.yaml` before
  disabling a rule. Generated files (`*.g.dart`, `*.gr.dart`) are excluded from analysis.
- **Never edit generated files** (`*.g.dart`, `*.freezed.dart`); change the source and re-run build_runner.
- **Test coverage is mandatory per-file**: `scripts/import_files_coverage.sh` fails CI if any `lib`
  file lacks a matching test. Add a test file under the mirrored `test/src/...` path for every new
  source file. Reusable test doubles live in `test/fakes/`.

## Working guidelines

Behavioral guidelines (from the `andrej-karpathy-skills` plugin) to reduce common coding mistakes.
These bias toward caution over speed — for trivial tasks, use judgment.

### 1. Think before coding

Don't assume, don't hide confusion, surface tradeoffs.

- State assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop, name what's confusing, and ask.

### 2. Simplicity first

Minimum code that solves the problem. Nothing speculative.

- No features beyond what was asked.
- No abstractions for single-use code, no unrequested "flexibility"/"configurability".
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.
- Ask: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical changes

Touch only what you must. Clean up only your own mess.

- Don't "improve" adjacent code, comments, or formatting; don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently (this repo's lint is already strict — see above).
- If you notice unrelated dead code, mention it — don't delete it unless asked.
- Remove imports/variables/functions that *your* changes made unused; leave pre-existing dead code alone.
- The test: every changed line should trace directly to the request.

### 4. Goal-driven execution

Define success criteria, then loop until verified. In this repo, "verified" means the CI gates pass:
`build_runner build` → `flutter analyze` → `import_files_coverage.sh` → `flutter test`.

- "Add validation" → write tests for invalid inputs, then make them pass.
- "Fix the bug" → write a test that reproduces it, then make it pass.
- "Refactor X" → ensure `flutter test` passes before and after.
- For multi-step tasks, state a brief plan with a verify step for each step.
