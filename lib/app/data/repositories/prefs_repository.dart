import 'package:flutter/material.dart';

import '../../services/prefs_service.dart';

class PrefsRepository {
  PrefsRepository(this._prefsService);

  final PrefsService _prefsService;

  bool get onboardingDone => _prefsService.onboardingDone;
  Future<void> setOnboardingDone(bool value) => _prefsService.setOnboardingDone(value);

  ThemeMode get themeMode => _prefsService.themeMode;
  Future<void> saveThemeMode(ThemeMode mode) => _prefsService.setThemeMode(mode);

  Locale get locale => _prefsService.locale;
  Future<void> saveLocale(Locale locale) => _prefsService.setLocale(locale);

  Map<String, dynamic>? get authUser => _prefsService.authUser;
  Future<void> saveAuthUser(Map<String, dynamic>? user) =>
      _prefsService.saveAuthUser(user);

  List<String> get favorites => _prefsService.favorites;
  Future<void> saveFavorites(List<String> ids) =>
      _prefsService.setFavorites(ids);

  List<Map<String, dynamic>> get cart => _prefsService.cartItems;
  Future<void> saveCart(List<Map<String, dynamic>> payload) =>
      _prefsService.setCartItems(payload);

  List<Map<String, dynamic>> get bookings => _prefsService.bookings;
  Future<void> saveBookings(List<Map<String, dynamic>> payload) =>
      _prefsService.setBookings(payload);

  Map<String, dynamic>? get flexPass => _prefsService.flexPass;
  Future<void> saveFlexPass(Map<String, dynamic>? payload) =>
      _prefsService.setFlexPass(payload);

  Map<String, dynamic> get savedFilters => _prefsService.savedFilters;
  Future<void> saveFilters(Map<String, dynamic> filters) =>
      _prefsService.setSavedFilters(filters);

  List<Map<String, dynamic>> get notifications => _prefsService.notifications;
  Future<void> saveNotifications(List<Map<String, dynamic>> payload) =>
      _prefsService.setNotifications(payload);
}
