import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}
