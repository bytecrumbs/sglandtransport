import 'package:flutter/material.dart';

class Platform {
  static bool isDarkMode(BuildContext context) {
    final brightnessValue = MediaQuery.of(context).platformBrightness;
    return brightnessValue == Brightness.dark;
  }
}
