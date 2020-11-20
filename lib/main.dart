import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:logging/logging.dart';
import 'environment_config.dart';
import 'my_app.dart';
import 'services/provider_logger.dart';

void main() {
  Level logLevel;
  if (foundation.kReleaseMode || EnvironmentConfig.isFlutterDriveRun) {
    logLevel = Level.WARNING;
  } else {
    logLevel = Level.ALL;
  }

  Logger.root.level = logLevel;
  Logger.root.onRecord.listen((record) {
    print('[${record.loggerName}]: ${record.level.name}: '
        '${record.time}: ${record.message}');
  });

  runApp(ProviderScope(
    child: MyApp(),
    observers: [ProviderLogger()],
  ));
}
