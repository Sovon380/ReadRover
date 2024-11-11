import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';           // Firebase core package
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'notifiers/theme_notifier.dart';
import 'localization/app_localizations.dart';                // Custom localization class
import 'home_page.dart';
import 'login_page.dart';
import 'main_navigation_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();                 // Ensures Flutter is initialized
  await Firebase.initializeApp();                            // Initializes Firebase
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: ReadRoverApp(),
    ),
  );
}

class ReadRoverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'ReadRover',
          theme: themeNotifier.currentTheme,                 // Apply the selected theme
          locale: themeNotifier.selectedLocale,              // Apply selected locale
          localizationsDelegates: [
            AppLocalizations.delegate,                       // Custom localization delegate
            GlobalMaterialLocalizations.delegate,            // Built-in localization
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,           // Cupertino support
          ],
          supportedLocales: [
            Locale('en', ''),                                // English
            Locale('bn', ''),                                // Bengali
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode) {
                return supportedLocale;
              }
            }
            // If not, fallback to the first supported locale
            return supportedLocales.first;
          },
          initialRoute: '/',                                 // Set HomePage as the initial route
          routes: {
            '/': (context) => HomePage(),
            '/login': (context) => LoginPage(),
            '/main': (context) => MainNavigationPage(),
          },
        );
      },
    );
  }
}
