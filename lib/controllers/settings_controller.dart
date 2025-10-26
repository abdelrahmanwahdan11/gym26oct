import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/localization/app_localizations.dart';
import '../data/repositories/prefs_repository.dart';

class SettingsController extends GetxController {
  SettingsController(this.prefs);

  final PrefsRepository prefs;

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = AppLocalizations.defaultLocale;
  bool _onboardingDone = false;

  ThemeMode get themeMode => _themeMode;
  Locale get currentLocale => _locale;
  bool get isArabic => _locale.languageCode == 'ar';
  String get initialRoute => _onboardingDone ? 'home.generator' : 'onboarding';

  @override
  void onInit() {
    super.onInit();
    bootstrap();
  }

  Future<void> bootstrap() async {
    _themeMode = prefs.loadThemeMode();
    _locale = prefs.loadLocale();
    _onboardingDone = prefs.isOnboardingDone();
    update();
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await prefs.saveThemeMode(_themeMode);
    update();
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await prefs.saveLocale(locale);
    update();
  }

  Future<void> markOnboardingComplete() async {
    _onboardingDone = true;
    await prefs.setOnboardingDone();
    update();
  }
}
