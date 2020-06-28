import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/favourites_service.dart';
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

import 'test_data.dart' as test_data;

class BusServiceMock extends Mock implements BusService {}

class FavouritesServiceMock extends Mock implements FavouritesService {}

class NavigationServiceMock extends Mock implements NavigationService {}

NavigationService getAndRegisterNavigationServiceMock() {
  _removeRegistrationIfExists<NavigationService>();
  var service = NavigationServiceMock();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

BusService getAndRegisterBusServiceMock({
  String busStopForBusArrival = '01019',
}) {
  _removeRegistrationIfExists<BusService>();
  var service = BusServiceMock();
  when(service.getBusArrivalServices(busStopForBusArrival)).thenAnswer(
    (realInvocation) {
      return Future.value(test_data.busArrivalServiceModelList);
    },
  );
  locator.registerSingleton<BusService>(service);
  return service;
}

FavouritesService getAndRegisterFavouritesServiceMock({
  bool isFavouriteReturnValue = false,
  String busStopCode = '01019',
}) {
  _removeRegistrationIfExists<FavouritesService>();
  var service = FavouritesServiceMock();
  when(service.isFavouriteBusStop(busStopCode)).thenAnswer((realInvocation) {
    return Future.value(isFavouriteReturnValue);
  });
  locator.registerSingleton<FavouritesService>(service);
  return service;
}

FirebaseAnalyticsService getAndRegisterFirebaseAnalyticsService() {
  _removeRegistrationIfExists<FirebaseAnalyticsService>();
  var service = FirebaseAnalyticsService();
  locator.registerSingleton<FirebaseAnalyticsService>(service);
  return service;
}

void registerServices() {
  getAndRegisterFirebaseAnalyticsService();
  getAndRegisterBusServiceMock();
  getAndRegisterFavouritesServiceMock();
  getAndRegisterNavigationServiceMock();
}

void unregisterServices() {
  locator.unregister<FirebaseAnalyticsService>();
  locator.unregister<BusService>();
  locator.unregister<FavouritesService>();
  locator.unregister<NavigationService>();
}

void _removeRegistrationIfExists<T>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
