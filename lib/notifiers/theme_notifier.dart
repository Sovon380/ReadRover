// lib/notifiers/theme_notifier.dart
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  Locale _selectedLocale = const Locale('en'); // Default locale set to English

  bool get isDarkMode => _isDarkMode;
  Locale get selectedLocale => _selectedLocale;

  ThemeData get currentTheme => _isDarkMode ? ThemeData.dark() : ThemeData.light();

  void toggleTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners(); // Notify all listeners to rebuild with the new theme
  }

  void setLocale(Locale locale) {
    _selectedLocale = locale;
    notifyListeners(); // Notify listeners to rebuild with the new locale
  }
}
