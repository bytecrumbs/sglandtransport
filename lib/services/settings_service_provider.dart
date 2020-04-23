import 'package:flutter/material.dart';

class SettingsServiceProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleDarkMode(bool value) {
    isDarkMode = value;
    notifyListeners();
  }
}
