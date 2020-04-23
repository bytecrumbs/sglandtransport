import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/services/settings_service_provider.dart';

void main() {
  test('toggle dark mode sets isDarkMode', () {
    final SettingsServiceProvider provider = SettingsServiceProvider();
    expect(provider.isDarkMode, false);
    provider.toggleDarkMode(true);
    expect(provider.isDarkMode, true);
  });

  test('toggle dark mode notifies listeners', () {
    int listenerCallCount = 0;
    final SettingsServiceProvider provider = SettingsServiceProvider()
      ..addListener(() {
        listenerCallCount += 1;
      });
    provider.toggleDarkMode(true);
    expect(listenerCallCount, 1);
  });
}
