// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:lta_datamall_flutter/services/api.dart';
import 'package:lta_datamall_flutter/services/bus_service.dart';
import 'package:lta_datamall_flutter/services/database_service.dart';
import 'package:lta_datamall_flutter/services/favourites_service.dart';
import 'package:lta_datamall_flutter/services/feature_service.dart';
import 'package:lta_datamall_flutter/services/firebase_analytics_service.dart';
import 'package:lta_datamall_flutter/services/location_service.dart';
import 'package:lta_datamall_flutter/services/thirdparty_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<Api>(() => Api());
  g.registerLazySingleton<BusService>(() => BusService());
  g.registerLazySingleton<DatabaseService>(() => DatabaseService());
  g.registerLazySingleton<FavouritesService>(() => FavouritesService());
  g.registerLazySingleton<FeatureService>(() => FeatureService());
  g.registerLazySingleton<FirebaseAnalyticsService>(
      () => FirebaseAnalyticsService());
  g.registerLazySingleton<LocationService>(() => LocationService());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  NavigationService get navigationService => NavigationService();
}
