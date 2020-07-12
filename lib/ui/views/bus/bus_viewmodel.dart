import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';
import 'package:stacked/stacked.dart';

class BusViewModel extends IndexTrackingViewModel {
  final _analyticsObserver =
      locator<FirebaseAnalyticsService>().analyticsObserver;

  String get appBarTitle => 'Buses';

  @override
  void setIndex(int index) {
    var longScreenName = 'BusIndex$index';
    _sendCurrentTabToAnalytics(longScreenName);
    super.setIndex(index);
  }

  void _sendCurrentTabToAnalytics(String screenName) {
    _analyticsObserver.analytics.setCurrentScreen(screenName: screenName);
  }
}
