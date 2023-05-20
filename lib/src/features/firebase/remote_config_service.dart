import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../third_party_providers/third_party_providers.dart';

part 'remote_config_service.g.dart';

@Riverpod(keepAlive: true)
class RemoteConfigService extends _$RemoteConfigService {
  final _showLastRefreshTimeKey = 'show_last_refresh_time';

  @override
  FutureOr<void> build() async {
    ref.watch(loggerProvider).d('Initializing Firebase Remote Config');
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await remoteConfig.setDefaults({
        _showLastRefreshTimeKey: false,
      });
      await remoteConfig.fetchAndActivate();
    } on FirebaseException catch (e) {
      ref
          .watch(loggerProvider)
          .d('Unable to initialize Firebase Remote Config: ${e.message}');
    }
  }

  bool getLastRefreshTime() {
    final remoteConfig = FirebaseRemoteConfig.instance;
    return remoteConfig.getBool(_showLastRefreshTimeKey);
  }
}
