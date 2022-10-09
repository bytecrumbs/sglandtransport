import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../constants/local_storage_keys.dart';
import 'local_storage_service.dart';
import 'third_party_providers.dart';

final rateAppServiceProvider = Provider(RateAppService.new);

class RateAppService {
  RateAppService(this._ref);

  final Ref _ref;

  Future<void> requestReview({bool force = false}) async {
    await setInitialLaunchDate(DateTime.now());
    await increaseLaunchCount();

    if (force || await isEligibleForReviewPrompt()) {
      final inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
        await setLastReviewPromptDate(DateTime.now());
        await increaseReviewPromptCount();
      }
    }
  }

  Future<bool> isEligibleForReviewPrompt() async {
    final firstLaunchDate =
        _ref.read(localStorageServiceProvider).getInt(firstLaunchKey)!;
    final currentLaunchCount =
        _ref.read(localStorageServiceProvider).getInt(launchCountKey)!;
    final lastReviewPromptDate =
        _ref.read(localStorageServiceProvider).getInt(lastReviewPromptKey);
    final currentReviewPromptCount =
        _ref.read(localStorageServiceProvider).getInt(reviewPromptCountKey);

    _ref.read(loggerProvider).d('First launch date: $firstLaunchDate');
    _ref.read(loggerProvider).d('Current launch count: $currentLaunchCount');
    _ref
        .read(loggerProvider)
        .d('Last review prompt date: $lastReviewPromptDate');
    _ref
        .read(loggerProvider)
        .d('Current review prompt count: $currentReviewPromptCount');

    final firstLaunchCheck = DateTime.now().millisecondsSinceEpoch >
        DateTime.fromMillisecondsSinceEpoch(firstLaunchDate)
            .add(const Duration(days: 7))
            .millisecondsSinceEpoch;

    final launchCountCheck = currentLaunchCount >= 10;

    final reviewPromptDateCheck = lastReviewPromptDate == null ||
        DateTime.now().millisecondsSinceEpoch >
            DateTime.fromMillisecondsSinceEpoch(lastReviewPromptDate)
                .add(const Duration(days: 7))
                .millisecondsSinceEpoch;

    final reviewPromptCountCheck =
        currentReviewPromptCount == null || currentReviewPromptCount >= 10;

    return firstLaunchCheck &&
        launchCountCheck &&
        reviewPromptDateCheck &&
        reviewPromptCountCheck;
  }

  Future<void> setInitialLaunchDate(DateTime launchDate) async {
    final firstLaunch =
        _ref.read(localStorageServiceProvider).getInt(firstLaunchKey);

    if (firstLaunch == null) {
      await _ref.read(localStorageServiceProvider).setInt(
            firstLaunchKey,
            launchDate.millisecondsSinceEpoch,
          );
    }
  }

  Future<void> increaseLaunchCount() async {
    await _increaseLocalStorageInt(launchCountKey);
  }

  Future<void> setLastReviewPromptDate(DateTime date) async {
    await _ref.read(localStorageServiceProvider).setInt(
          lastReviewPromptKey,
          date.millisecondsSinceEpoch,
        );
  }

  Future<void> increaseReviewPromptCount() async {
    await _increaseLocalStorageInt(reviewPromptCountKey);
  }

  Future<void> _increaseLocalStorageInt(String key) async {
    final count = _ref.read(localStorageServiceProvider).getInt(key) ?? 0;

    await _ref.read(localStorageServiceProvider).setInt(
          key,
          count + 1,
        );
  }
}
