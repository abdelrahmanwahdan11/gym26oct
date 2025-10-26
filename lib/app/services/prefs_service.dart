import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  PrefsService({required SharedPreferences sharedPreferences})
      : _prefs = sharedPreferences,
        _box = GetStorage();

  final SharedPreferences _prefs;
  final GetStorage _box;

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

  Future<void> setOnboardingDone(bool value) =>
      _prefs.setBool(onboardingKey, value);

  Map<String, dynamic>? get authUser {
    final raw = _box.read(authUserKey);
    if (raw is String && raw.isNotEmpty) {
      return jsonDecode(raw) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> saveAuthUser(Map<String, dynamic>? user) async {
    if (user == null) {
      await _box.remove(authUserKey);
    } else {
      await _box.write(authUserKey, jsonEncode(user));
    }
  }

  ThemeMode get themeMode {
    final value = _box.read(themeModeKey);
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) =>
      _box.write(themeModeKey, mode.name);

  Locale get locale {
    final value = _box.read(localeKey) as String?;
    if (value == null) {
      return const Locale('ar');
    }
    final parts = value.split('_');
    if (parts.length == 2) {
      return Locale(parts.first, parts.last);
    }
    return Locale(value);
  }

  Future<void> setLocale(Locale locale) =>
      _box.write(localeKey, locale.toLanguageTag());

  List<String> get favorites =>
      List<String>.from(_box.read(favoritesKey) ?? const <String>[]);

  Future<void> setFavorites(List<String> ids) =>
      _box.write(favoritesKey, ids);

  List<Map<String, dynamic>> get cartItems {
    final raw = _box.read(cartKey);
    if (raw is List) {
      return raw.cast<Map<String, dynamic>>();
    }
    return const [];
  }

  Future<void> setCartItems(List<Map<String, dynamic>> values) =>
      _box.write(cartKey, values);

  List<Map<String, dynamic>> get bookings {
    final raw = _box.read(bookingsKey);
    if (raw is List) {
      return raw.cast<Map<String, dynamic>>();
    }
    return const [];
  }

  Future<void> setBookings(List<Map<String, dynamic>> values) =>
      _box.write(bookingsKey, values);

  Map<String, dynamic>? get flexPass =>
      _box.read(flexPassKey) as Map<String, dynamic>?;

  Future<void> setFlexPass(Map<String, dynamic>? value) async {
    if (value == null) {
      await _box.remove(flexPassKey);
    } else {
      await _box.write(flexPassKey, value);
    }
  }

  Map<String, dynamic> get savedFilters =>
      Map<String, dynamic>.from(_box.read(savedFiltersKey) ?? const {});

  Future<void> setSavedFilters(Map<String, dynamic> value) =>
      _box.write(savedFiltersKey, value);

  List<Map<String, dynamic>> get notifications =>
      List<Map<String, dynamic>>.from(_box.read(notificationsKey) ?? const []);

  Future<void> setNotifications(List<Map<String, dynamic>> values) =>
      _box.write(notificationsKey, values);
}
