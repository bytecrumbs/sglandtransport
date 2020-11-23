import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:logging/logging.dart';
import 'environment_config.dart';
import 'my_app.dart';
import 'services/provider_logger.dart';

Future<void> warmupFlare() async {
  await cachedActor(AssetFlare(bundle: rootBundle, name: 'images/city.flr'));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlareCache.doesPrune = false;

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

  warmupFlare().then((_) {
    runApp(ProviderScope(
      child: MyApp(),
      observers: [ProviderLogger()],
    ));
  });
}
