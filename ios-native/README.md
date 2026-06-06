# SG Land Transport — native iOS (SwiftUI)

Native SwiftUI rewrite of the Flutter app (`lta_datamall_flutter`), iOS only. See the migration
plan and `../CONTEXT.md` / `../docs/adr/` for background. Ships as an update to the existing app
(bundle id `com.saschaderungs.ltaDatamall`).

- **Min iOS:** 17.0
- **Persistence:** SwiftData
- **Project generation:** [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`project.yml` is the
  source of truth; `*.xcodeproj` is generated and gitignored)

## One-time setup

```bash
brew install xcodegen          # if not already installed

cd ios-native
cp Configs/Secrets.example.xcconfig Configs/Secrets.local.xcconfig
# edit Configs/Secrets.local.xcconfig and set LTA_DATAMALL_API_KEY (https://datamall.lta.gov.sg/)

xcodegen generate              # creates SGLandTransport.xcodeproj
open SGLandTransport.xcodeproj
```

The API key is injected from `Secrets.local.xcconfig` → build setting → `Info.plist`
(`LTADatamallAPIKey`) → `AppConfig.ltaDatamallAPIKey`. If it's missing the app fails loudly at
launch (parity with the Flutter `AssertionError`).

## Run on a simulator

In Xcode pick an **iOS 17** simulator and ⌘R. Or from the CLI:

```bash
xcodegen generate
xcodebuild -scheme SGLandTransport \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.5' build

# run UI tests (stub mode)
xcodebuild -scheme SGLandTransport \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.5' test
```

### Simulating a Singapore location (for Nearby Stops)

The simulator has no GPS. In Xcode: **Features ▸ Location ▸ Custom Location…** and enter a Singapore
coordinate (e.g. `1.2845, 103.8510` — Raffles Place). Nearby Stops resolves against that.

## Project layout

```
ios-native/
├── project.yml                 # XcodeGen definition
├── Configs/                    # .xcconfig (API key injection; Secrets.local is gitignored)
├── Resources/                  # Info.plist, Assets.xcassets
├── Sources/
│   ├── App/                    # App entry, RootView shell, AppConfig, launch args
│   ├── DesignSystem/           # Palette (ported from palette.dart), BottomBar
│   └── Features/               # Feature screens (added per milestone)
└── Tests/UITests/              # XCUITest suite (smoke now; per-feature parity tests later)
```
