fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios test

```sh
[bundle exec] fastlane ios test
```

Push a new beta build to TestFlight

### ios increment_build_number_ios

```sh
[bundle exec] fastlane ios increment_build_number_ios
```



### ios add_new_devices

```sh
[bundle exec] fastlane ios add_new_devices
```

Registers new devices to Dev Portal and auto re-generate the provisioning profile if necessary

### ios upload_firebase

```sh
[bundle exec] fastlane ios upload_firebase
```

Upload to Firebase

### ios set_release_version

```sh
[bundle exec] fastlane ios set_release_version
```

Sets the version of the bundle to a RELEASE_VERSION passed in as an environment variable

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Push a new beta build to TestFlight

### ios submit_review

```sh
[bundle exec] fastlane ios submit_review
```



### ios release

```sh
[bundle exec] fastlane ios release
```



----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
