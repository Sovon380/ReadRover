import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // This method helps to access the localization data from anywhere in the app.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // A map to hold the localized strings.
  Map<String, String>? _localizedStrings;

  // This method loads the JSON file and sets up the translations.
  Future<bool> load() async {
    // Load the JSON file from assets based on the current locale.
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  // This method fetches a translated string by key.
  String translate(String key) {
    return _localizedStrings![key] ?? key;
  }

  // A delegate to help load and reload localization files.
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  // Supported locales for the app.
  @override
  bool isSupported(Locale locale) => ['en', 'bn'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // Create an instance of AppLocalizations for the given locale.
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  // Reload localization if the locale changes.
  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
