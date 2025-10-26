import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  PrefsService({required SharedPreferences sharedPreferences})
      : _prefs = sharedPreferences;

  final SharedPreferences _prefs;

  static const String onboardingKey = 'onboarding_done';
  static const String authUserKey = 'auth_user';
  static const String themeModeKey = 'theme_mode';
  static const String localeKey = 'locale';
  static const String favoritesKey = 'favorites';
  static const String cartKey = 'cart';
  static const String bookingsKey = 'bookings';
  static const String flexPassKey = 'flexpass';
  static const String savedFiltersKey = 'saved_filters';
  static const String notificationsKey = 'notifications';

  bool get onboardingDone => _prefs.getBool(onboardingKey) ?? false;

  Future<void> setOnboardingDone(bool value) async {
    await _prefs.setBool(onboardingKey, value);
  }

  Map<String, dynamic>? get authUser => _readMap(authUserKey);

  Future<void> saveAuthUser(Map<String, dynamic>? user) async {
    if (user == null) {
      await _prefs.remove(authUserKey);
    } else {
      await _prefs.setString(authUserKey, jsonEncode(user));
    }
  }

  ThemeMode get themeMode {
    final value = _prefs.getString(themeModeKey);
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(themeModeKey, mode.name);
  }

  Locale get locale {
    final value = _prefs.getString(localeKey);
    if (value == null) {
      return const Locale('ar');
    }
    final parts = value.split('_');
    if (parts.length == 2) {
      return Locale(parts.first, parts.last);
    }
    return Locale(value);
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(localeKey, locale.toLanguageTag());
  }

  List<String> get favorites =>
      _prefs.getStringList(favoritesKey) ?? const <String>[];

  Future<void> setFavorites(List<String> ids) async {
    await _prefs.setStringList(favoritesKey, ids);
  }

  List<Map<String, dynamic>> get cartItems => _readMapList(cartKey);

  Future<void> setCartItems(List<Map<String, dynamic>> values) async {
    await _prefs.setString(cartKey, jsonEncode(values));
  }

  List<Map<String, dynamic>> get bookings => _readMapList(bookingsKey);

  Future<void> setBookings(List<Map<String, dynamic>> values) async {
    await _prefs.setString(bookingsKey, jsonEncode(values));
  }

  Map<String, dynamic>? get flexPass => _readMap(flexPassKey);

  Future<void> setFlexPass(Map<String, dynamic>? value) async {
    if (value == null) {
      await _prefs.remove(flexPassKey);
    } else {
      await _prefs.setString(flexPassKey, jsonEncode(value));
    }
  }

  Map<String, dynamic> get savedFilters =>
      _readMap(savedFiltersKey) ?? const <String, dynamic>{};

  Future<void> setSavedFilters(Map<String, dynamic> value) async {
    await _prefs.setString(savedFiltersKey, jsonEncode(value));
  }

  List<Map<String, dynamic>> get notifications =>
      _readMapList(notificationsKey);

  Future<void> setNotifications(List<Map<String, dynamic>> values) async {
    await _prefs.setString(notificationsKey, jsonEncode(values));
  }

  Map<String, dynamic>? _readMap(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    try {
      final data = jsonDecode(raw);
      if (data is Map) {
        return Map<String, dynamic>.from(data as Map);
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  List<Map<String, dynamic>> _readMapList(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) {
      return const <Map<String, dynamic>>[];
    }
    try {
      final data = jsonDecode(raw);
      if (data is List) {
        return data
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
      }
    } catch (_) {
      return const <Map<String, dynamic>>[];
    }
    return const <Map<String, dynamic>>[];
  }
}
