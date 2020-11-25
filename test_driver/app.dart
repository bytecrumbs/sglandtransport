import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/flare_testing.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:logging/logging.dart';
import 'package:lta_datamall_flutter/app/bus/bus_nearby_view.dart';
import 'package:lta_datamall_flutter/my_app.dart';
import 'package:lta_datamall_flutter/services/provider_logger.dart';

Future<void> warmupFlare() async {
  await cachedActor(AssetFlare(bundle: rootBundle, name: 'images/city.flr'));
}

void main() {
  WidgetsApp.debugAllowBannerOverride = false;
  FlareTesting.setup();
  enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();

  FlareCache.doesPrune = false;

  final logLevel = Level.WARNING;

  Logger.root.level = logLevel;
  Logger.root.onRecord.listen((record) {
    print('[${record.loggerName}]: ${record.level.name}: '
        '${record.time}: ${record.message}');
  });

  final fakeLocationStreamProvider =
      StreamProvider.autoDispose<LocationData>((ref) async* {
    yield LocationData.fromMap(
      {
        'latitude': 1.29685,
        'longitude': 103.853,
      },
    );
  });

  warmupFlare().then((_) {
    runApp(ProviderScope(
      overrides: [
        locationStreamProvider.overrideWithProvider(
          fakeLocationStreamProvider,
        ),
      ],
      child: MyApp(),
      observers: [ProviderLogger()],
    ));
  });
}
