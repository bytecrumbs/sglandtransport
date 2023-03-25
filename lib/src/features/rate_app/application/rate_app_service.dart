import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../local_storage/local_storage_keys.dart';
import '../../../local_storage/local_storage_service.dart';
import '../../../third_party_providers/third_party_providers.dart';

part 'rate_app_service.g.dart';

@Riverpod(keepAlive: true)
RateAppService rateAppService(RateAppServiceRef ref) => RateAppService(ref);

class RateAppService {
  RateAppService(this.ref);

  final Ref ref;

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
        await ref.read(localStorageServiceProvider).getInt(firstLaunchKey) ??
            DateTime.now().millisecondsSinceEpoch;
    final currentLaunchCount =
        await ref.read(localStorageServiceProvider).getInt(launchCountKey) ?? 1;

    ref.read(loggerProvider).d('First launch date: $firstLaunchDate');
    ref.read(loggerProvider).d('Current launch count: $currentLaunchCount');

    final firstLaunchCheck = DateTime.now().millisecondsSinceEpoch >
        DateTime.fromMillisecondsSinceEpoch(firstLaunchDate)
            .add(const Duration(days: 7))
            .millisecondsSinceEpoch;

    final launchCountCheck = currentLaunchCount >= 10;

    return firstLaunchCheck && launchCountCheck;
  }

  Future<void> setLastLaunchDate({DateTime? launchDate}) async {
    final firstLaunch =
        await ref.read(localStorageServiceProvider).getInt(firstLaunchKey);

    if (firstLaunch == null || launchDate != null) {
      final launchDateToSet = launchDate ?? DateTime.now();
      await ref.read(localStorageServiceProvider).setInt(
            firstLaunchKey,
            launchDateToSet.millisecondsSinceEpoch,
          );
    }
  }

  Future<void> increaseLaunchCount() async {
    final count =
        await ref.read(localStorageServiceProvider).getInt(launchCountKey) ?? 0;
    await _setLaunchCount(launchCountKey, count + 1);
  }

  Future<void> _setLaunchCount(String key, int count) async {
    await ref.read(localStorageServiceProvider).setInt(
          key,
          count,
        );
  }

  Future<void> resetLaunchCount() async {
    await _setLaunchCount(launchCountKey, 0);
  }
}
