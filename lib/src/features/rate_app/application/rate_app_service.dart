import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../constants/local_storage_keys.dart';
import '../../../shared/application/local_storage_service.dart';
import '../../../shared/third_party_providers.dart';

final rateAppServiceProvider = Provider(RateAppService.new);

class RateAppService {
  RateAppService(this._ref);

  final Ref _ref;

  Future<void> requestReview({bool force = false}) async {
    await setLastLaunchDate();
    await increaseLaunchCount();

    if (force || await isEligibleForReviewPrompt()) {
      final inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
        await setLastLaunchDate(launchDate: DateTime.now());
        await resetLaunchCount();
      }
    }
  }

  Future<bool> isEligibleForReviewPrompt() async {
    final firstLaunchDate =
        _ref.read(localStorageServiceProvider).getInt(firstLaunchKey)!;
    final currentLaunchCount =
        _ref.read(localStorageServiceProvider).getInt(launchCountKey)!;

    _ref.read(loggerProvider).d('First launch date: $firstLaunchDate');
    _ref.read(loggerProvider).d('Current launch count: $currentLaunchCount');

    final firstLaunchCheck = DateTime.now().millisecondsSinceEpoch >
        DateTime.fromMillisecondsSinceEpoch(firstLaunchDate)
            .add(const Duration(days: 7))
            .millisecondsSinceEpoch;

    final launchCountCheck = currentLaunchCount >= 10;

    return firstLaunchCheck && launchCountCheck;
  }

  Future<void> setLastLaunchDate({DateTime? launchDate}) async {
    final firstLaunch =
        _ref.read(localStorageServiceProvider).getInt(firstLaunchKey);

    if (firstLaunch == null || launchDate != null) {
      final launchDateToSet = launchDate ?? DateTime.now();
      await _ref.read(localStorageServiceProvider).setInt(
            firstLaunchKey,
            launchDateToSet.millisecondsSinceEpoch,
          );
    }
  }

  Future<void> increaseLaunchCount() async {
    final count =
        _ref.read(localStorageServiceProvider).getInt(launchCountKey) ?? 0;
    await _setLaunchCount(launchCountKey, count + 1);
  }

  Future<void> _setLaunchCount(String key, int count) async {
    await _ref.read(localStorageServiceProvider).setInt(
          key,
          count,
        );
  }

  Future<void> resetLaunchCount() async {
    await _setLaunchCount(launchCountKey, 0);
  }
}
