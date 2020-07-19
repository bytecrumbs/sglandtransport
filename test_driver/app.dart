import 'package:flare_flutter/flare_testing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:lta_datamall_flutter/main.dart' as app;

void main() {
  WidgetsApp.debugAllowBannerOverride = false;
  FlareTesting.setup();
  enableFlutterDriverExtension();
  app.main();
}
