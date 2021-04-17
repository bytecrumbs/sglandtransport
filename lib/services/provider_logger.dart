import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

/// Main logging class for all the Riverpod providers
class ProviderLogger extends ProviderObserver {
  static final _log = Logger('ProviderLogger');
  @override
  void didAddProvider(ProviderBase provider, Object? value) {
    super.didAddProvider(provider, value);
    _log.info('''
adding: {
  "provider": "${provider.name ?? provider.runtimeType}",
  "value": "$value"
}
    ''');
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue) {
    super.didUpdateProvider(provider, newValue);
    _log.info('''
updating: {
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}
    ''');
  }

  @override
  void didDisposeProvider(ProviderBase provider) {
    super.didDisposeProvider(provider);
    _log.info('''
disposing: {
  "provider": "${provider.name ?? provider.runtimeType}"
}
    ''');
  }
}
