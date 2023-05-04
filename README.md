# SG Land Transport

![GitHub][license badge]
[![Twitter handle][]][twitter badge]

[![Test](https://github.com/bytecrumbs/sglandtransport/actions/workflows/test.yml/badge.svg)](https://github.com/bytecrumbs/sglandtransport/actions/workflows/test.yml)
[![Create Release](https://github.com/bytecrumbs/sglandtransport/actions/workflows/create_release.yml/badge.svg)](https://github.com/bytecrumbs/sglandtransport/actions/workflows/create_release.yml)

[![codecov](https://codecov.io/gh/bytecrumbs/sglandtransport/branch/master/graph/badge.svg?token=J6ATK9J4F6)](https://codecov.io/gh/bytecrumbs/sglandtransport)

Public transport made easy, providing screens and functionality based on APIs that are exposed by the LTA Datamall (https://www.mytransport.sg/content/mytransport/home/dataMall.html)

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

## Prerequisites

### Flutter

- Flutter (https://flutter.dev/docs/get-started/install)

#### LTA Datamall API key

This app will attempt to read the LTA Datamall key from a file called api-keys.json in your project root directory.

Example api-keys.json file:

```json
{
    "LTA_DATAMALL_API_KEY": "your-key"
}
```

For VSCode, a launch.json file is a there, with the necessary configuration.

To run it from command line:

```zsh
flutter run --dart-define-from-file=api-keys.json
```

A key can be generated following the guildeines of

You can generate a key following the guidelines of the [Land Transport Datamall](https://datamall.lta.gov.sg/content/datamall/en/dynamic-data.html).

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
flutter drive --target=test_driver/app.dart --dart-define=LTA_DATAMALL_API_KEY=<your LTA Datamall API key>
```

## Deployments

### TestFlight

#### GitHub Actions

TBD

#### Manually from Dev Machine

Ensure you have an SSH key properly set up. You can follow [this guideline from GitHub](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account). When creating the SSH key, ensure to leave the passphrase empty!

To test if you have the necessary rights and all is setup correctly, please try to run `git clone git@github.com:bytecrumbs/certificates.git`, which should complete successfully, without prompting any passphrase.

Once the above works successfully, you can create a new Testflight version manually from your local machine using following steps:

```zsh

# generate required files using build_runner
flutter pub run build_runner build --delete-conflicting-outputs

# ensure the tests are passing
flutter test

# ensure you have the correct fastlane version installed
cd ios
bundle install

# store the version number in an environment variable
RELEASE_VERSION=<version_number>
export RELEASE_VERSION

# configure App Store Connect API
ASCAPI_KEY_ID=<key_id>
export ASCAPI_KEY_ID
ASCAPI_ISSUER_ID=<issuer_id>
export ASCAPI_ISSUER_ID
ASCAPI_KEY_CONTENT=<key_content>
export ASCAPI_KEY_CONTENT

# set new version and build number
bundle exec fastlane set_release_version

# build a release version of the app
flutter build ios --release --no-codesign --dart-define=LTA_DATAMALL_API_KEY=<your LTA Datamall API key>

# upload the built version to Testflight
bundle exec fastlane beta
```

There is no need to push the changes that `bundle exec fastlane set_release_version` has caused, you can savely discard those changes, as they will be overwritten again with above commands when the next build is produced.

#### iOS TestFlight from CI/CD:

```
cd ios
bundle exec fastlane testflight_from_ci
```

Note:
Authentication with Apple services: Several Fastlane actions communicate with Apple services that need authentication. This can pose several challenges on CI. More info, use this link: https://docs.fastlane.tools/best-practices/continuous-integration/#application-specific-passwords

An Apple ID session is only valid for a certain region, meaning if your CI system is in a different region than your local machine, you might run into issues
An Apple ID session is only valid for up to a month, meaning you'll have to generate a new session every month. Usually you'd only know about it when your build starts failing

### iOS Firebase App Distribution from Local:

#### Upload build using Fastlane

1. Set up fastlane and Add App Distribution to your fastlane configuration

```
bundle exec fastlane add_plugin firebase_app_distribution
```

2. Authenticate With Firebase

#### To install the Firebase CLI using the automatic install script

```
curl -sL https://firebase.tools | bash
```

3. Log into Firebase using your Google account

```
firebase login:ci
```

4. Get the token and set FIREBASE_TOKEN

```
export FIREBASE_TOKEN=token_from_ci
```

#### Android internal test track:

```
cd android
bundle exec fastlane deploy_internal
```

## Production deployments

### Submit for Apple Review

```
cd ios
bundle exec fastlane submit_review
```

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

[license badge]: https://img.shields.io/github/license/bytecrumbs/sglandtransport
[twitter handle]: https://img.shields.io/twitter/follow/sgltapp.svg?style=social&label=Follow
[twitter badge]: https://twitter.com/intent/follow?screen_name=sgltapp

## Usage of REST Client plugin
In order to query sample results from the LTA datamall, install the VS Code plugin `REST Client` and create a `settings.json` file inside the `.vscode` folder, like so:

```json
{
    "rest-client.environmentVariables": {
        "local": {
            "baseURL": "http://datamall2.mytransport.sg",
            "authorization": "<LTA datamall key>"
        }
    }
}
```

Once this is done, you can start to query using the `ltadatamall.http` file.
