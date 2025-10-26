import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/cart_item.dart';

class PrefsRepository {
  PrefsRepository(this.prefs, [GetStorage? storage]) : box = storage ?? GetStorage();

  final SharedPreferences prefs;
  final GetStorage box;

  static const _themeKey = 'theme';
  static const _localeKey = 'locale';
  static const _onboardingKey = 'onboarding_done';
  static const _cartKey = 'cart_items';
  static const _favoritesKey = 'favorites';
  static const _bookingsKey = 'bookings';
  static const _flexPassKey = 'flexpass';

  ThemeMode loadThemeMode() {
    final value = box.read<String>(_themeKey) ?? prefs.getString(_themeKey);
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
    await box.write(_themeKey, value);
  }

  Locale loadLocale() {
    final value = box.read<String>(_localeKey) ?? prefs.getString(_localeKey);
    if (value == null) {
      return const Locale('ar');
    }
    return Locale(value);
  }

  Future<void> saveLocale(Locale locale) async {
    await prefs.setString(_localeKey, locale.languageCode);
    await box.write(_localeKey, locale.languageCode);
  }

  bool isOnboardingDone() => box.read<bool>(_onboardingKey) ?? prefs.getBool(_onboardingKey) ?? false;

  Future<void> setOnboardingDone() async {
    await prefs.setBool(_onboardingKey, true);
    await box.write(_onboardingKey, true);
  }

  List<CartItem> loadCartItems() {
    final jsonString = box.read<String>(_cartKey) ?? prefs.getString(_cartKey);
    if (jsonString == null) return [];
    final list = (json.decode(jsonString) as List)
        .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
    return list;
  }

  Future<void> saveCartItems(List<CartItem> items) async {
    final encoded = json.encode(items.map((e) => e.toJson()).toList());
    await prefs.setString(_cartKey, encoded);
    await box.write(_cartKey, encoded);
  }

  Set<String> loadFavorites() {
    final stored = box.read<List<dynamic>>(_favoritesKey);
    if (stored != null) {
      return stored.map((e) => e.toString()).toSet();
    }
    return prefs.getStringList(_favoritesKey)?.toSet() ?? {};
  }

  Future<void> saveFavorites(Set<String> ids) async {
    final list = ids.toList();
    await prefs.setStringList(_favoritesKey, list);
    await box.write(_favoritesKey, list);
  }

  List<Map<String, dynamic>> loadBookings() {
    final jsonString = box.read<String>(_bookingsKey) ?? prefs.getString(_bookingsKey);
    if (jsonString == null) return [];
    final list = (json.decode(jsonString) as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    return list;
  }

  Future<void> saveBookings(List<Map<String, dynamic>> bookings) async {
    final encoded = json.encode(bookings);
    await prefs.setString(_bookingsKey, encoded);
    await box.write(_bookingsKey, encoded);
  }

  Map<String, dynamic>? loadFlexPass() {
    final value = box.read<String>(_flexPassKey) ?? prefs.getString(_flexPassKey);
    if (value == null) return null;
    return Map<String, dynamic>.from(json.decode(value) as Map);
  }

  Future<void> saveFlexPass(Map<String, dynamic> json) async {
    final encoded = json.encode(json);
    await prefs.setString(_flexPassKey, encoded);
    await box.write(_flexPassKey, encoded);
  }
}
