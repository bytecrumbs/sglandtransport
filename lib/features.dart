import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/routes/router.gr.dart';

class Features {
  static final Features _features = Features._internal();

  factory Features() {
    return _features;
  }

  Features._internal();

  List<Feature> getListOfFeatures() {
    if (kReleaseMode) {
      return ReleaseFeatures;
    } else {
      return DevFeatures;
    }
  }
}

const List<Feature> DevFeatures = [
  busesFeature,
  aboutFeature,
];

const List<Feature> ReleaseFeatures = [
  busesFeature,
  aboutFeature,
];

const Feature busesFeature = Feature(
  title: 'Buses',
  routeName: Routes.mainBusScreenRoute,
  icon: Icon(Icons.directions_bus),
);

const Feature aboutFeature = Feature(
  title: 'About',
  routeName: Routes.aboutScreenRoute,
  icon: Icon(Icons.info_outline),
);

class Feature {
  const Feature({
    @required this.title,
    @required this.routeName,
    @required this.icon,
  });

  final String title;
  final String routeName;
  final Icon icon;
}
