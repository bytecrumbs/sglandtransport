import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:lta_datamall_flutter/src/features/rate_app/application/rate_app_service.dart';
import 'package:lta_datamall_flutter/src/local_storage/local_storage_keys.dart';
import 'package:lta_datamall_flutter/src/local_storage/local_storage_service.dart';
import 'package:lta_datamall_flutter/src/third_party_providers/third_party_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('RateAppService should', () {
    Future<ProviderContainer> _setup(Map<String, Object> values) async {
      SharedPreferences.setMockInitialValues(values);

      return ProviderContainer(
        overrides: [
          loggerProvider.overrideWithValue(
            Logger(
              printer: PrettyPrinter(),
              level: Level.error,
            ),
          ),
        ],
      );
    }

    test('set initial launch date if it does not yet exist', () async {
      final container = await _setup({});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      expect(
        await localStorageService.getInt(firstLaunchKey) == null,
        true,
      );
      await rateAppService.setLastLaunchDate();

      expect(
        (await localStorageService.getInt(firstLaunchKey))! > 0,
        true,
      );
    });
    test('not override the launch date if it already exists', () async {
      final existingFirstLaunchDate =
          DateTime.utc(1989, 11, 9).millisecondsSinceEpoch;

      final container = await _setup({firstLaunchKey: existingFirstLaunchDate});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      await rateAppService.setLastLaunchDate();

      expect(
        await localStorageService.getInt(firstLaunchKey),
        existingFirstLaunchDate,
      );
    });
    test(' override the launch date if it is passed in', () async {
      final existingFirstLaunchDate =
          DateTime.utc(1989, 11, 9).millisecondsSinceEpoch;

      final container = await _setup({firstLaunchKey: existingFirstLaunchDate});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      final setNewLaunchDate = DateTime.utc(2022, 12);

      await rateAppService.setLastLaunchDate(launchDate: setNewLaunchDate);

      expect(
        await localStorageService.getInt(firstLaunchKey),
        setNewLaunchDate.millisecondsSinceEpoch,
      );
    });
    test('set launch count to 1, if the entry does not yet exist', () async {
      final container = await _setup({});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      await rateAppService.increaseLaunchCount();

      expect(
        await localStorageService.getInt(launchCountKey),
        1,
      );
    });

    test('set launch count +1, if the entry already exists', () async {
      const currentLaunchCount = 3;
      final container = await _setup({launchCountKey: currentLaunchCount});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      await rateAppService.increaseLaunchCount();

      expect(
        await localStorageService.getInt(launchCountKey),
        currentLaunchCount + 1,
      );
    });
    test('reset the count to 0', () async {
      const currentLaunchCount = 3;
      final container = await _setup({launchCountKey: currentLaunchCount});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      await rateAppService.resetLaunchCount();

      expect(
        await localStorageService.getInt(launchCountKey),
        0,
      );
    });

    test('show review prompt as eligible when launched before given threshold',
        () async {
      final firstLaunchDate =
          DateTime.now().add(const Duration(days: -7)).millisecondsSinceEpoch;
      const currentLaunchCount = 10;
      final container = await _setup({
        launchCountKey: currentLaunchCount,
        firstLaunchKey: firstLaunchDate,
      });

      final isEligible = await container
          .read(rateAppServiceProvider)
          .isEligibleForReviewPrompt();

      expect(isEligible, true);
    });

    test(
        'show review prompt as not eligible when launched before given first launch threshold',
        () async {
      final firstLaunchDate =
          DateTime.now().add(const Duration(days: -6)).millisecondsSinceEpoch;
      const currentLaunchCount = 10;
      final container = await _setup({
        launchCountKey: currentLaunchCount,
        firstLaunchKey: firstLaunchDate,
      });

      final isEligible = await container
          .read(rateAppServiceProvider)
          .isEligibleForReviewPrompt();

      expect(isEligible, false);
    });
    test(
        'show review prompt as not eligible when launched before given launch count threshold',
        () async {
      final firstLaunchDate =
          DateTime.now().add(const Duration(days: -7)).millisecondsSinceEpoch;
      const currentLaunchCount = 9;
      final container = await _setup({
        launchCountKey: currentLaunchCount,
        firstLaunchKey: firstLaunchDate,
      });

      final isEligible = await container
          .read(rateAppServiceProvider)
          .isEligibleForReviewPrompt();

      expect(isEligible, false);
    });
  });
}
