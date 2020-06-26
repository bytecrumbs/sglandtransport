import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';

FirebaseAnalyticsService getAndRegisterFirebaseAnalyticsService() {
  _removeRegistrationIfExists<FirebaseAnalyticsService>();
  var service = FirebaseAnalyticsService();
  locator.registerSingleton<FirebaseAnalyticsService>(service);
  return service;
}

void registerServices() {
  getAndRegisterFirebaseAnalyticsService();
}

void unregisterServices() {
  locator.unregister<FirebaseAnalyticsService>();
}

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
