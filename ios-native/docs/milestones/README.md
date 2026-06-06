# Milestones — native iOS (SwiftUI) rewrite

Each milestone is a self-contained, independently verifiable slice of the native iOS rewrite.
The authoritative background is the approved migration plan; `../../../CONTEXT.md` (glossary) and
`../../../docs/adr/` give domain context. Flutter source paths referenced in each file are the
behavior-parity source of truth.

| # | Milestone | Status |
|---|-----------|--------|
| [M1](./M1.md) | Skeleton & infra (buildable SwiftUI shell on simulator) | ✅ Completed |
| [M1b](./M1b.md) | Firebase (SPM) + GoogleService-Info + Crashlytics wiring | ⬜ Pending |
| [M2](./M2.md) | Networking + Codable models (LTAClient) | ⬜ Pending |
| [M3](./M3.md) | SwiftData mirror + refresh + queries | ⬜ Pending |
| [M4](./M4.md) | Favorites / UserDefaults migration shim | ⬜ Pending |
| [M5](./M5.md) | Nearby Stops + Bus Arrivals screens | ⬜ Pending |
| [M6](./M6.md) | Favorites + Service details + Route timeline + Search + About/Share/Review | ⬜ Pending |
| [M7](./M7.md) | Polish & parity pass | ⬜ Pending |
| [M8](./M8.md) | Release plumbing (Fastlane + CI + TestFlight) | ⬜ Pending |

## Conventions

- **Confirmed decisions** (apply throughout): ship as an **update to the same bundle id**
  `com.saschaderungs.ltaDatamall` (so favorites must migrate from the Flutter `UserDefaults`
  `flutter.*` keys); **min iOS 17**; **SwiftData** for the local mirror; **hero animation rebuilt
  natively** in SwiftUI.
- **Parity gate (M5 onward):** a feature is "done" only when its XCUITest passes **and** its parity
  screenshot is signed off against the running Flutter app. Signed-off screenshots become snapshot
  baselines. Tracked in `../parity/` (created in M5).
- **Project regen:** after adding/removing source files, run `xcodegen generate` (the `.xcodeproj`
  is generated and gitignored).
