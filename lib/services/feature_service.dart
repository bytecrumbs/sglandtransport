import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:lta_datamall_flutter/datamodels/feature.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';

@lazySingleton
class FeatureService {
  static final _busesFeature = Feature(
    title: 'Buses',
    routeName: Routes.busViewRoute,
    icon: Icon(Icons.directions_bus),
  );

  final _devFeatures = [_busesFeature];
  List<Feature> get devFeatures => _devFeatures;

  final _releaseFeatures = [_busesFeature];
  List<Feature> get releaseFeatures => _releaseFeatures;

  List<Feature> getListOfFeatures() {
    if (foundation.kReleaseMode) {
      return releaseFeatures;
    } else {
      return devFeatures;
    }
  }
}
