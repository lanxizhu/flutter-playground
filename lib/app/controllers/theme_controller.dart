import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();
  }

  void useSystemMode() {
    setThemeMode(ThemeMode.system);
  }

  void useLightMode() {
    setThemeMode(ThemeMode.light);
  }

  void useDarkMode() {
    setThemeMode(ThemeMode.dark);
  }
}
