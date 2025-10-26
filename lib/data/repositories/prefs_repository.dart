import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/cart_item.dart';

class PrefsRepository {
  PrefsRepository(this.prefs);

  final SharedPreferences prefs;

  static const _themeKey = 'theme';
  static const _localeKey = 'locale';
  static const _onboardingKey = 'onboarding_done';
  static const _cartKey = 'cart_items';
  static const _favoritesKey = 'favorites';
  static const _bookingsKey = 'bookings';
  static const _flexPassKey = 'flexpass';

  ThemeMode loadThemeMode() {
    final value = prefs.getString(_themeKey);
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final value = mode == ThemeMode.dark
        ? 'dark'
        : mode == ThemeMode.light
            ? 'light'
            : 'system';
    await prefs.setString(_themeKey, value);
  }

  Locale loadLocale() {
    final value = prefs.getString(_localeKey);
    if (value == null || value.isEmpty) {
      return const Locale('ar');
    }
    return Locale(value);
  }

  Future<void> saveLocale(Locale locale) async {
    await prefs.setString(_localeKey, locale.languageCode);
  }

  bool isOnboardingDone() => prefs.getBool(_onboardingKey) ?? false;

  Future<void> setOnboardingDone() async {
    await prefs.setBool(_onboardingKey, true);
  }

  List<CartItem> loadCartItems() {
    final jsonString = prefs.getString(_cartKey);
    if (jsonString == null) return [];
    final list = (json.decode(jsonString) as List)
        .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
    return list;
  }

  Future<void> saveCartItems(List<CartItem> items) async {
    final encoded = json.encode(items.map((e) => e.toJson()).toList());
    await prefs.setString(_cartKey, encoded);
  }

  Set<String> loadFavorites() {
    final stored = prefs.getStringList(_favoritesKey);
    if (stored == null) {
      return {};
    }
    return stored.toSet();
  }

  Future<void> saveFavorites(Set<String> ids) async {
    await prefs.setStringList(_favoritesKey, ids.toList());
  }

  List<Map<String, dynamic>> loadBookings() {
    final jsonString = prefs.getString(_bookingsKey);
    if (jsonString == null) return [];
    final list = (json.decode(jsonString) as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    return list;
  }

  Future<void> saveBookings(List<Map<String, dynamic>> bookings) async {
    final encoded = json.encode(bookings);
    await prefs.setString(_bookingsKey, encoded);
  }

  Map<String, dynamic>? loadFlexPass() {
    final value = prefs.getString(_flexPassKey);
    if (value == null) return null;
    return Map<String, dynamic>.from(json.decode(value) as Map);
  }

  Future<void> saveFlexPass(Map<String, dynamic> json) async {
    final encoded = json.encode(json);
    await prefs.setString(_flexPassKey, encoded);
  }
}
