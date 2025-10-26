import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/prefs_repository.dart';

class ThemeController extends GetxController {
  ThemeController(this._prefsRepository);

  final PrefsRepository _prefsRepository;

  final _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _themeMode.value = _prefsRepository.themeMode;
  }

  Future<void> toggleTheme() async {
    final newMode =
        _themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _themeMode.value = newMode;
    await _prefsRepository.saveThemeMode(newMode);
    update();
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode.value = mode;
    await _prefsRepository.saveThemeMode(mode);
    update();
  }
}
