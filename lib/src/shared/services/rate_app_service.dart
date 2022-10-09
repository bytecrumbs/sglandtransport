import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';

final rateAppServiceProvider = Provider<RateAppService>((ref) {
  return RateAppService();
});

class RateAppService {
  Future<void> requestReview({bool force = false}) async {
    if (force) {
      final inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        await inAppReview.requestReview();
      }
    }
  }
}
