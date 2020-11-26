fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios test
```
fastlane ios test
```
Push a new beta build to TestFlight
### ios increment_build_number_ios
```
fastlane ios increment_build_number_ios
```

### ios testflight_from_local
```
fastlane ios testflight_from_local
```

### ios add_new_devices
```
fastlane ios add_new_devices
```
Registers new devices to Dev Portal and auto re-generate the provisioning profile if necessary
### ios upload_firebase
```
fastlane ios upload_firebase
```
Upload to Firebase
### ios testflight_from_ci
```
fastlane ios testflight_from_ci
```

### ios submit_review
```
fastlane ios submit_review
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
