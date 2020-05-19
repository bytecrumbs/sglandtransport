# LTA Datamall app

[![Build Status](https://api.cirrus-ci.com/github/sderungs99/sglandtransport.svg)](https://cirrus-ci.com/github/sderungs99/sglandtransport)

This app provides screens and functionality for APIs that are exposed by the LTA Datamall (https://www.mytransport.sg/content/mytransport/home/dataMall.html)

## Contributing

Refer to the [Contributing Guidelines](CONTRIBUTING.md).

## Code of Conduct

Our code of conduct is based on the [Contributor Covenant](CODE_OF_CONDUCT.md).

## Setup

### Secret keys

This project reads keys from environment variables. For local development, we are using package https://pub.dev/packages/flutter_dotenv. To set this up:

1. Create a .env file in the root folder of your project
2. Generate a key following the guidelines of https://www.mytransport.sg/content/mytransport/home/dataMall/dynamic-data.html
3. Update your .env file to something like this:

```
LTA_DATAMALL_KEY=<the secret key you received from above step 2>
```

### Google Firebase

Follow the instructions on https://firebase.google.com/docs/flutter/setup?platform=ios (as well as for Android) to add the necessary files related to Google Firebase services.

## Prerequisites

### Flutter

- Flutter (https://flutter.dev/docs/get-started/install)

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

## Screenshot Commandline utility

### Installation

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

```
screenshots -m recording
```

## Generate new set of app icon

1. Place your icon `app-icon.png` image in `images/` folder
2. Run the following command `flutter pub run flutter_launcher_icons:main`

## Maintainers

<a href="https://github.com/ameego"><img width="60" height="60" src="https://github.com/ameego.png?size=500"/></a>
<a href="https://github.com/bobrenji"><img width="60" height="60" src="https://github.com/bobrenji.png?size=500"/></a>
<a href="https://github.com/sderungs99"><img width="60" height="60" src="https://github.com/sderungs99.png?size=500"/></a>
