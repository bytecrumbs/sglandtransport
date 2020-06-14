import 'package:lta_datamall_flutter/app/locator.dart';
import 'package:lta_datamall_flutter/datamodels/feature.dart';
import 'package:lta_datamall_flutter/services/feature_service.dart';
import 'package:stacked/stacked.dart';

class AppDrawerViewModel extends BaseViewModel {
  final _featureService = locator<FeatureService>();

  final String _version = '1.0.1';
  String get version => _version;

  List<Feature> getActiveFeatures() {
    return _featureService.getListOfFeatures();
  }
}
