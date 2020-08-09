import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/feature.dart';
import 'package:lta_datamall_flutter/services/feature_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppDrawerViewModel extends BaseViewModel {
  final _featureService = locator<FeatureService>();
  final _navigationService = locator<NavigationService>();

  final String _version = '1.2.0';
  String get version => _version;

  List<Feature> getActiveFeatures() {
    return _featureService.getListOfFeatures();
  }

  Future navigateTo(String routeName) async {
    await _navigationService.navigateTo(routeName);
  }
}
