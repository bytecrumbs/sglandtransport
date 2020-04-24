echo "Create simulator"
xcrun simctl create iOS13TestDevice "iPhone 11" com.apple.CoreSimulator.SimRuntime.iOS-13-4
echo "Boot"
xcrun simctl boot iOS13TestDevice
echo "Check boot status"
xcrun simctl bootstatus iOS13TestDevice
echo "Run driver tests"
flutter drive --target=test_driver/app.dart --debug & applesimutils --byName "iOS13TestDevice" --bundle "com.saschaderungs.ltaDatamall" --setPermissions "location=always" || sleep 90