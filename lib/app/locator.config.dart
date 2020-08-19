// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api.dart';
import '../services/bus_service.dart';
import '../services/database_service.dart';
import '../services/favourites_service.dart';
import '../services/feature_service.dart';
import '../services/firebase_analytics_service.dart';
import '../services/location_service.dart';
import '../services/thirdparty_services_module.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<Api>(() => Api());
  gh.lazySingleton<BusService>(() => BusService());
  gh.lazySingleton<DatabaseService>(() => DatabaseService());
  gh.lazySingleton<FavouritesService>(() => FavouritesService());
  gh.lazySingleton<FeatureService>(() => FeatureService());
  gh.lazySingleton<FirebaseAnalyticsService>(() => FirebaseAnalyticsService());
  gh.lazySingleton<LocationService>(() => LocationService());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  NavigationService get navigationService => NavigationService();
}
