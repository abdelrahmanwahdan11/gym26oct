import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/prefs_repository.dart';

class LocaleController extends GetxController {
  LocaleController(this._prefsRepository);

  final PrefsRepository _prefsRepository;
  final _locale = const Locale('ar').obs;

  Locale get locale => _locale.value;

  bool get isArabic => _locale.value.languageCode == 'ar';

  @override
  void onInit() {
    super.onInit();
    _locale.value = _prefsRepository.locale;
  }

  Future<void> setLocale(Locale locale) async {
    _locale.value = locale;
    await _prefsRepository.saveLocale(locale);
    Get.updateLocale(locale);
    update();
  }
}
