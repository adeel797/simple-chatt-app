import 'package:chat_app/theme/dark_mode.dart';
import 'package:chat_app/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider class to manage theme state (light/dark mode)
class ThemeProvider extends ChangeNotifier {
  // Current theme, defaults to light mode
  ThemeData _themeData = lightMode;

  // Getter for the current theme
  ThemeData get themeData => _themeData;

  // Getter to check if dark mode is active
  bool get isDarkMode => _themeData == darkMode;

  // Constructor to load theme on initialization
  ThemeProvider() {
    loadTheme();
  }

  // Load theme preference from shared preferences
  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDark = prefs.getBool('isDarkMode') ?? false; // Default to light mode
    _themeData = isDark ? darkMode : lightMode;
    notifyListeners();
  }

  // Save theme preference to shared preferences
  Future<void> saveTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  // Setter to update the theme and save preference
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    saveTheme(_themeData == darkMode);
    notifyListeners();
  }

  // Toggle between light and dark mode
  void toggleTheme() {
    bool isDark = _themeData == darkMode;
    _themeData = isDark ? lightMode : darkMode;
    saveTheme(!isDark);
    notifyListeners();
  }
}