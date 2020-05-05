# LTA Datamall app

This app provides screens and functionality for APIs that are exposed by the LTA Datamall (https://www.mytransport.sg/content/mytransport/home/dataMall.html)

## Prerequisites

### Flutter

- Flutter (https://flutter.dev/docs/get-started/install)

### API Keys

#### LTA Datamall

1. Generate a key following the guidelines of https://www.mytransport.sg/content/mytransport/home/dataMall/dynamic-data.html
2. Update the constant "ltaDatamallKey" in file lib/constants.dart with the key you have generated above. For example:

```
const String ltaDatamallKey = '1234asdf3dfaasdf';
```

## Code Generation

This project uses build runner to generate Models (lib/models) and Routes (lib/routes).

### Generate once

```
flutter pub run build_runner build --delete-conflicting-outputs
```

### Watch and generate on change

```
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Deployments

This project is using Fastlane (https://fastlane.tools/) as its deployment pipeline.

### Beta deployments

#### To deploy to iOS TestFlight from local:

```
cd ios
bundle exec fastlane beta
```

#### To deploy to Android beta from local:

TBD

## Production deployments

TBD

## Run test, generate coverage and convert to HTML

### Installing dependency

```
brew install lcov
```

### Run tests, generate coverage files and convert to HTML

```
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Run automation

1. Install AppleSimulatorUtils

- `brew tap wix/brew`
- `brew install applesimutils`

2. Run tests. From root:

```
./execute_ui_tests.sh
```
