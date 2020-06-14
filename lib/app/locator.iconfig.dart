// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:lta_datamall_flutter/services/feature_service.dart';
import 'package:lta_datamall_flutter/services/thirdparty_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<FeatureService>(() => FeatureService());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  NavigationService get navigationService => NavigationService();
}
