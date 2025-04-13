import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeAppProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeAppProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTheme = prefs.getString('themeMode') ?? 'system';

    if (storedTheme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (storedTheme == 'light') {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> _saveTheme(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode);
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      _saveTheme('dark');
    } else {
      _themeMode = ThemeMode.light;
      _saveTheme('light');
    }
    notifyListeners();
  }

  void setSystemTheme() {
    _themeMode = ThemeMode.system;
    _saveTheme('system');
    notifyListeners();
  }
}
