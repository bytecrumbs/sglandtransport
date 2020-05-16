import 'package:flutter_driver/driver_extension.dart';
import 'package:lta_datamall_flutter/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  WidgetsApp.debugAllowBannerOverride = false;
  app.main();
}
