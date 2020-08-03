# SG Land Transport

![GitHub][license badge]
[![Build Status - Cirrus][]][build status]
[![Build Status - Cirrus analyze][]][build status]
[![Build Status - Cirrus unit_test][]][build status]
[![Twitter handle][]][twitter badge]

Publc transport made easy, providing screens and functionality based on APIs that are exposed by the LTA Datamall (https://www.mytransport.sg/content/mytransport/home/dataMall.html)

## Download official apps

<a href="https://play.google.com/store/apps/details?id=com.saschaderungs.ltaDatamall">
  <img alt="Download on Google Play" src="https://play.google.com/intl/en_us/badges/images/badge_new.png" height=43>
</a>
<a href="https://apps.apple.com/sg/app/sg-land-transport/id1504247137">
  <img alt="Download on App Store" src="https://user-images.githubusercontent.com/7317008/43209852-4ca39622-904b-11e8-8ce1-cdc3aee76ae9.png" height=43>
</a>

## Contributing

Refer to the [Contributing Guidelines](CONTRIBUTING.md).

## Code of Conduct

Our code of conduct is based on the [Contributor Covenant](CODE_OF_CONDUCT.md).

## Setup

### Secret keys

#### LTA Datamall API key

This key is read during build time from an environment variable named "LTA_DATAMALL_API_KEY". Environment variables can be read in 2 ways:

1. from command line:

```
flutter run ---dart-define=LTA_DATAMALL_API_KEY=<add your key here>
```

2. From an environment variable on your CI server (see this project's .cirrus.yml file for an example)

You can generate a key following the guidelines of https://www.mytransport.sg/content/mytransport/home/dataMall/dynamic-data.html

If you use VSCode, we recommend you create a launch.json file that launches the flutter run command with this argument, so that you can use the standard debug functionality of VSCode, rather than running your debug build via the command line.

Example launch.json file:

```json
{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=LTA_DATAMALL_API_KEY=<your LTA Datamall API key goes here"
      ]
    }
  ]
}
```

### Google Firebase

Follow the instructions on https://firebase.google.com/docs/flutter/setup?platform=ios (as well as for Android) to add the necessary files related to Google Firebase services.

## Prerequisites

### Flutter

- Flutter (https://flutter.dev/docs/get-started/install)

## Code Generation

This project uses build runner to generate Models, Routes and other things.

### Generate once

```
flutter pub run build_runner build --delete-conflicting-outputs
```

### Watch and generate on change

```
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Running tests

### Installing dependences

```
brew install lcov
```

### Run tests, generate coverage files and convert to HTML

```
./prepare_test_coverage.sh lta_datamall_flutter
flutter test --coverage
lcov --list coverage/lcov.info
genhtml coverage/lcov.info --output=coverage
```

### Run Integration (UI) Tests

```
flutter drive --target=test_driver/app.dart --dart-define=IS_FLUTTER_DRIVE_RUN=true --dart-define=LTA_DATAMALL_API_KEY=<your LTA Datamall API key>
```

IMPORTANT NOTE: above argument '--dart-define=IS_FLUTTER_DRIVE_RUN=true'. This is used so that in the code we can check if the app is run using flutter drive and therefore some specific checks can be made (i.e. the flare animation will not animate when running 'flutter drive')

Alternatively, refer to the Screenshots section below, which will run the same integration tests as well.

## Deployments

### Beta deployments

Deployments can be run from your local machine

#### iOS TestFlight:

```
cd ios
bundle exec fastlane testflight_from_local LTA_DATAMALL_API_KEY:<add your key here>
```

#### Android internal test track:

```
cd android
bundle exec fastlane deploy_internal
```

## Production deployments

TBD

## Screenshot Commandline utility

### Installing dependencies

```
brew update && brew install imagemagick
pub global activate screenshots
```

Note: If pub is not found, add to PATH using:

On macOS:

```
export PATH="<path to flutter installation directory>/bin/cache/dart-sdk/bin:$PATH"
```

### Usage

To create screenshots to upload via fastlane, run following command without any mode.

```
screenshots
```

If mode is recording, screenshots will be saved for later comparison

```
screenshots -m recording
```

If mode is archive, screenshots will be archived (and cannot be uploaded via fastlane).

```
screenshots -m archive
```

## Generate new set of app icon

1. Place your icon `app-icon.png` image in `images/` folder
2. Run the following command `flutter pub run flutter_launcher_icons:main`

## Maintainers

<a href="https://github.com/ameego"><img width="60" height="60" src="https://github.com/ameego.png?size=500"/></a>
<a href="https://github.com/bobrenji"><img width="60" height="60" src="https://github.com/bobrenji.png?size=500"/></a>
<a href="https://github.com/sderungs99"><img width="60" height="60" src="https://github.com/sderungs99.png?size=500"/></a>

[license badge]: https://img.shields.io/github/license/sderungs99/sglandtransport
[twitter handle]: https://img.shields.io/twitter/follow/sgltapp.svg?style=social&label=Follow
[twitter badge]: https://twitter.com/intent/follow?screen_name=sgltapp
[build status - cirrus]: https://api.cirrus-ci.com/github/sderungs99/sglandtransport.svg
[build status - cirrus analyze]: https://api.cirrus-ci.com/github/sderungs99/sglandtransport.svg?task=analyze
[build status - cirrus unit_test]: https://api.cirrus-ci.com/github/sderungs99/sglandtransport.svg?task=unit_test
[build status]: https://cirrus-ci.com/github/sderungs99/sglandtransport/master
