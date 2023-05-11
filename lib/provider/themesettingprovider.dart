import 'package:flutter/cupertino.dart';

class ThemeSettingProvider extends ChangeNotifier {
  bool _isDarkModeEnabled = false;
  bool _isCustomThemeEnabled = false;
  bool isDarkModeEnabled() => _isDarkModeEnabled;
  bool isCustomThemeEnabled() => _isCustomThemeEnabled;

  void toggleDarkMode(bool value) {
    _isDarkModeEnabled = value;
    notifyListeners();
  }

  void toggleCustomTheme(bool value) {
    _isCustomThemeEnabled = value;
    notifyListeners();
  }
}
