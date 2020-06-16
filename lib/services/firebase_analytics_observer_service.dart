import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirebaseAnalyticsObserverService {
  final FirebaseAnalyticsObserver _analyticsObserver =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics());
  FirebaseAnalyticsObserver get analyticsObserver => _analyticsObserver;
}
