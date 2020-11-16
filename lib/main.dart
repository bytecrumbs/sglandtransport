import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/environment_config.dart';
import 'my_app.dart';

void main() {
  Level logLevel;
  if (foundation.kReleaseMode || EnvironmentConfig.isFlutterDriveRun) {
    logLevel = Level.WARNING;
  } else {
    logLevel = Level.ALL;
  }

  Logger.root.level = logLevel;
  Logger.root.onRecord.listen((record) {
    print(
        '[${record.loggerName}]: ${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(MyApp());
}
