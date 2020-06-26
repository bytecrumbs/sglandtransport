import 'package:flutter/material.dart';

class Feature {
  Feature({
    @required this.title,
    @required this.routeName,
    @required this.icon,
  });

  final String title;
  final String routeName;
  final Icon icon;
}
