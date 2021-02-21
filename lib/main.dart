import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_app.dart';
import 'services/local_storage_service.dart';
import 'services/provider_logger.dart';

/// Preload Flare asset
Future<void> warmupFlare() async {
  await cachedActor(AssetFlare(bundle: rootBundle, name: 'images/city.flr'));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  FlareCache.doesPrune = false;

  Level logLevel;
  if (foundation.kReleaseMode) {
    logLevel = Level.WARNING;
  } else {
    logLevel = Level.ALL;
  }

  Logger.root.level = logLevel;
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('[${record.loggerName}]: ${record.level.name}: '
        '${record.time}: ${record.message}');
  });

  await warmupFlare();
  runApp(ProviderScope(
    overrides: [
      localStorageServiceProvider.overrideWithValue(
        LocalStorageService(sharedPreferences),
      )
    ],
    observers: [ProviderLogger()],
    child: const MyApp(),
  ));
}
