import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lta_datamall_flutter/src/constants/local_storage_keys.dart';
import 'package:lta_datamall_flutter/src/shared/services/local_storage_service.dart';
import 'package:lta_datamall_flutter/src/shared/services/rate_app_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('RateAppService should', () {
    Future<ProviderContainer> _setup(Map<String, Object> values) async {
      SharedPreferences.setMockInitialValues(values);

      final sharedPreferences = await SharedPreferences.getInstance();
      return ProviderContainer(
        overrides: [
          localStorageServiceProvider.overrideWithValue(
            LocalStorageService(sharedPreferences),
          )
        ],
      );
    }

    test('set initial launch date if it does not yet exist', () async {
      final container = await _setup({});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);
      final definedLaunchDate = DateTime.utc(1989, 11, 9);

      await rateAppService.setInitialLaunchDate(definedLaunchDate);

      expect(
        localStorageService.getInt(firstLaunchKey),
        definedLaunchDate.millisecondsSinceEpoch,
      );
    });
    test('not override the launch date if it already exists', () async {
      final existingFirstLaunchDate =
          DateTime.utc(1989, 11, 9).millisecondsSinceEpoch;

      final container = await _setup({firstLaunchKey: existingFirstLaunchDate});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);
      final definedLaunchDate = DateTime.now();

      await rateAppService.setInitialLaunchDate(definedLaunchDate);

      expect(
        localStorageService.getInt(firstLaunchKey),
        existingFirstLaunchDate,
      );
    });
    test('set launch count to 1, if the entry does not yet exist', () async {
      final container = await _setup({});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      await rateAppService.increaseLaunchCount();

      expect(
        localStorageService.getInt(launchCountKey),
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
        localStorageService.getInt(launchCountKey),
        currentLaunchCount + 1,
      );
    });
    test('set review prompt date', () async {
      final container = await _setup({});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      final definedLastReviewPromptDate = DateTime.utc(1989, 11, 9);

      await rateAppService.setLastReviewPromptDate(definedLastReviewPromptDate);

      expect(
        localStorageService.getInt(lastReviewPromptKey),
        definedLastReviewPromptDate.millisecondsSinceEpoch,
      );
    });
    test('set review prompt count to 1, if the entry does not yet exist',
        () async {
      final container = await _setup({});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      await rateAppService.increaseReviewPromptCount();

      expect(
        localStorageService.getInt(reviewPromptCountKey),
        1,
      );
    });

    test('set review prompt count +1, if the entry already exists', () async {
      const currentReviewPromptCount = 3;
      final container =
          await _setup({reviewPromptCountKey: currentReviewPromptCount});

      final rateAppService = container.read(rateAppServiceProvider);
      final localStorageService = container.read(localStorageServiceProvider);

      await rateAppService.increaseReviewPromptCount();

      expect(
        localStorageService.getInt(reviewPromptCountKey),
        currentReviewPromptCount + 1,
      );
    });
    test('''
show review prompt as eligible when launched before given threshold 
        and no review prompt has been set yet''', () async {
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
    test('''
show review prompt as eligible when launched before given threshold 
        and last review prompt has been show before given threshold''',
        () async {
      final firstLaunchDate =
          DateTime.now().add(const Duration(days: -7)).millisecondsSinceEpoch;
      final lastReviewPromptDate =
          DateTime.now().add(const Duration(days: -7)).millisecondsSinceEpoch;
      const currentLaunchCount = 10;
      const currentReviewPromptCount = 10;
      final container = await _setup({
        launchCountKey: currentLaunchCount,
        firstLaunchKey: firstLaunchDate,
        lastReviewPromptKey: lastReviewPromptDate,
        reviewPromptCountKey: currentReviewPromptCount,
      });

      final isEligible = await container
          .read(rateAppServiceProvider)
          .isEligibleForReviewPrompt();

      expect(isEligible, true);
    });
    test('''
show review prompt as not eligible when launched before given first launch threshold 
        and no review prompt has been set yet''', () async {
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
    test('''
show review prompt as not eligible when launched before given launch count threshold 
        and no review prompt has been set yet''', () async {
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
    test('''
show review prompt as not eligible when launched after given first launch threshold 
        and last review was shown before given threshold''', () async {
      final firstLaunchDate =
          DateTime.now().add(const Duration(days: -7)).millisecondsSinceEpoch;
      const currentLaunchCount = 10;
      final lastReviewPromptDate =
          DateTime.now().add(const Duration(days: -6)).millisecondsSinceEpoch;
      const currentReviewPromptCount = 10;
      final container = await _setup({
        launchCountKey: currentLaunchCount,
        firstLaunchKey: firstLaunchDate,
        lastReviewPromptKey: lastReviewPromptDate,
        reviewPromptCountKey: currentReviewPromptCount,
      });

      final isEligible = await container
          .read(rateAppServiceProvider)
          .isEligibleForReviewPrompt();

      expect(isEligible, false);
    });
    test('''
show review prompt as not eligible when launched after given first launch threshold 
        and review prompt count is below given threshold''', () async {
      final firstLaunchDate =
          DateTime.now().add(const Duration(days: -7)).millisecondsSinceEpoch;
      const currentLaunchCount = 10;
      final lastReviewPromptDate =
          DateTime.now().add(const Duration(days: -7)).millisecondsSinceEpoch;
      const currentReviewPromptCount = 9;
      final container = await _setup({
        launchCountKey: currentLaunchCount,
        firstLaunchKey: firstLaunchDate,
        lastReviewPromptKey: lastReviewPromptDate,
        reviewPromptCountKey: currentReviewPromptCount,
      });

      final isEligible = await container
          .read(rateAppServiceProvider)
          .isEligibleForReviewPrompt();

      expect(isEligible, false);
    });
  });
}
