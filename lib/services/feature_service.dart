import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lta_datamall_flutter/app/router.gr.dart';
import 'package:lta_datamall_flutter/datamodels/feature.dart';

@lazySingleton
class FeatureService {
  static final _busFeature = Feature(
    title: 'Buses',
    routeName: Routes.busView,
    icon: Icon(Icons.directions_bus),
  );

  static final _inAppPurchaseFeature = Feature(
    title: 'InApp - Purchase',
    routeName: Routes.marketScreen,
    icon: Icon(Icons.donut_small),
  );

  final _devFeatures = [_busFeature, _inAppPurchaseFeature];
  List<Feature> get devFeatures => _devFeatures;

  final _releaseFeatures = [_busFeature, _inAppPurchaseFeature];
  List<Feature> get releaseFeatures => _releaseFeatures;

  List<Feature> getListOfFeatures() {
    if (foundation.kReleaseMode) {
      return releaseFeatures;
    } else {
      return devFeatures;
    }
  }
}
