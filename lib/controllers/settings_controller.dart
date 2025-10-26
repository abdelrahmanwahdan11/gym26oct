import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/localization/app_localizations.dart';
import '../data/repositories/prefs_repository.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(this.prefs);

  final PrefsRepository prefs;

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = AppLocalizations.defaultLocale;
  bool _onboardingDone = false;

  ThemeMode get themeMode => _themeMode;
  Locale get currentLocale => _locale;
  bool get isArabic => _locale.languageCode == 'ar';
  String get initialRoute => _onboardingDone ? 'home.generator' : 'onboarding';

  Future<void> bootstrap() async {
    _themeMode = prefs.loadThemeMode();
    _locale = prefs.loadLocale();
    _onboardingDone = prefs.isOnboardingDone();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await prefs.saveThemeMode(_themeMode);
    Get.changeThemeMode(_themeMode);
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await prefs.saveLocale(locale);
    Get.updateLocale(locale);
    notifyListeners();
  }

  Future<void> markOnboardingComplete() async {
    _onboardingDone = true;
    await prefs.setOnboardingDone();
    notifyListeners();
  }
}
